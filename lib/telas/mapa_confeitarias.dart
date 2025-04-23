import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:confeitaria_marketplace/database/app_database.dart';

class MapaConfeitaria extends StatefulWidget {
  final Confeitaria confeitaria;
  final AppDatabase db;

  const MapaConfeitaria({
    super.key,
    required this.confeitaria,
    required this.db,
  });

  @override
  _MapaConfeitariaState createState() => _MapaConfeitariaState();
}

class _MapaConfeitariaState extends State<MapaConfeitaria> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition;
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Define a posição inicial como a localização da confeitaria
    _initialPosition = LatLng(
      widget.confeitaria.latitude,
      widget.confeitaria.longitude,
    );
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    try {
      final BitmapDescriptor icon = await _getCustomIcon();

      setState(() {
        _customIcon = icon;
        _markers = {
          Marker(
            markerId: MarkerId(widget.confeitaria.id.toString()),
            position: _initialPosition,
            infoWindow: InfoWindow(
              title: widget.confeitaria.nome,
              snippet:
                  '${widget.confeitaria.rua}, ${widget.confeitaria.numero}',
            ),
            icon: _customIcon ?? BitmapDescriptor.defaultMarker,
          )
        };
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar ícone: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<BitmapDescriptor> _getCustomIcon() async {
    try {
      final ByteData data = await rootBundle.load('assets/images/cupcake.png');
      final Uint8List bytes = data.buffer.asUint8List();

      final ui.Codec codec =
          await ui.instantiateImageCodec(bytes, targetWidth: 80);
      final ui.FrameInfo frame = await codec.getNextFrame();
      final ByteData? byteData =
          await frame.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedBytes = byteData!.buffer.asUint8List();

      return BitmapDescriptor.fromBytes(resizedBytes);
    } catch (e) {
      print("Falha ao carregar ícone customizado, usando padrão");
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.confeitaria.nome),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadCustomIcon,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 16, // Zoom mais próximo para focar melhor na confeitaria
              ),
              markers: _markers,
              onMapCreated: (controller) {
                _mapController = controller;
                // Centraliza o mapa na confeitaria após o carregamento
                _mapController.animateCamera(
                  CameraUpdate.newLatLng(_initialPosition),
                );
              },
              myLocationEnabled: true,
              compassEnabled: true,
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.gps_fixed),
        onPressed: () {
          if (_mapController != null && _initialPosition != null) {
            _mapController.animateCamera(
              CameraUpdate.newLatLng(_initialPosition),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
