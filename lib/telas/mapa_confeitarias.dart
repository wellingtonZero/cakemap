import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/detalhes_confeitarias.dart';

class MapaConfeitaria extends StatefulWidget {
  final AppDatabase db;
  final Confeitaria? confeitariaSelecionada;

  const MapaConfeitaria({
    super.key,
    required this.db,
    this.confeitariaSelecionada,
  });

  @override
  _MapaConfeitariaState createState() => _MapaConfeitariaState();
}

class _MapaConfeitariaState extends State<MapaConfeitaria> {
  GoogleMapController? _mapController;
  LatLng? _initialPosition;
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon().then((_) => _loadConfeitarias());
  }

  Future<void> _loadCustomIcon() async {
    try {
      final ByteData data = await rootBundle.load('assets/images/cupcake.png');
      final Uint8List bytes = data.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: 120, // Tamanho ideal para marcadores
      );
      final ui.FrameInfo frame = await codec.getNextFrame();
      final ByteData? byteData = await frame.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List resizedBytes = byteData!.buffer.asUint8List();
      _customIcon = BitmapDescriptor.fromBytes(resizedBytes);
    } catch (e) {
      debugPrint("Erro ao carregar ícone: $e");
      // Fallback para ícone padrão rosa
      _customIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    }
  }

  Future<void> _loadConfeitarias() async {
    final confeitarias = await widget.db.select(widget.db.confeitarias).get();

    setState(() {
      _markers = confeitarias.map((confeitaria) {
        final position = LatLng(confeitaria.latitude, confeitaria.longitude);
        
        // Define posição inicial se for a confeitaria selecionada ou a primeira da lista
        if (widget.confeitariaSelecionada?.id == confeitaria.id || 
            (_initialPosition == null && confeitarias.indexOf(confeitaria) == 0)) {
          _initialPosition = position;
        }

        return Marker(
          markerId: MarkerId(confeitaria.id.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: confeitaria.nome,
            snippet: '${confeitaria.bairro}',
            onTap: () => _navigateToDetails(confeitaria),
          ),
          icon: _customIcon!, // Usa o mesmo ícone para todas
          onTap: () {
            _mapController?.showMarkerInfoWindow(MarkerId(confeitaria.id.toString()));
          },
        );
      }).toSet();

      _isLoading = false;
    });

    // Foca na confeitaria selecionada após o carregamento
    if (widget.confeitariaSelecionada != null && _mapController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(
              widget.confeitariaSelecionada!.latitude,
              widget.confeitariaSelecionada!.longitude,
            ),
            16, // Zoom mais próximo
          ),
        );
      });
    }
  }

  void _navigateToDetails(Confeitaria confeitaria) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalharConfeitaria(
          db: widget.db,
          confeitaria: confeitaria,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.confeitariaSelecionada?.nome ?? 'Confeitarias no Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                _markers.clear();
              });
              _loadConfeitarias();
            },
          ),
        ],
      ),
      body: _isLoading || _initialPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition!,
                zoom: widget.confeitariaSelecionada != null ? 16 : 12,
              ),
              markers: _markers,
              onMapCreated: (controller) {
                _mapController = controller;
                // Mostra todos os infowindows
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  for (final marker in _markers) {
                    _mapController?.showMarkerInfoWindow(marker.markerId);
                  }
                });
              },
              myLocationEnabled: true,
              compassEnabled: true,
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.gps_fixed),
        onPressed: () {
          if (_initialPosition != null && _mapController != null) {
            _mapController?.animateCamera(
              CameraUpdate.newLatLng(_initialPosition!),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}