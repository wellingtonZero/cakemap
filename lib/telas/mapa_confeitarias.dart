import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;


class MapaConfeitaria extends StatefulWidget {
  const MapaConfeitaria({super.key});

  @override
  _MapaConfeitariaState createState() => _MapaConfeitariaState();
}

class _MapaConfeitariaState extends State<MapaConfeitaria> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = LatLng(-6.77088,-35.01584);//-23.5505, -46.6333
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    try {
      // 1. Carrega o ícone personalizado
      final BitmapDescriptor icon = await _getCustomIcon();
      
      // 2. Carrega as confeitarias (simuladas)
      final List<Map<String, dynamic>> fakeConfeitarias = [
        {
          'id': '1',
          'nome': 'Doces da Maria',
          'lat': -23.5515,
          'lng': -46.6343,
          'tipo': 'bolo'
        },
        {
          'id': '2',
          'nome': 'Cupcake Mania',
          'lat': -23.5490,
          'lng': -46.6320,
          'tipo': 'cupcake'
        },
      ];

      // 3. Cria os marcadores
      setState(() {
        _customIcon = icon;
        _markers = fakeConfeitarias.map((confeitaria) {
          return Marker(
            markerId: MarkerId(confeitaria['id']),
            position: LatLng(confeitaria['lat'], confeitaria['lng']),
            infoWindow: InfoWindow(
              title: confeitaria['nome']),
            icon: _customIcon!, // Usa o ícone carregado
            onTap: () => _showConfeitariaDetails(confeitaria['id']),
          );
        }).toSet();
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar ícone: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<BitmapDescriptor> _getCustomIcon() async {
    try {
      // Carrega a imagem do asset
      final ByteData data = await rootBundle.load('assets/images/cupcake.png');
      final Uint8List bytes = data.buffer.asUint8List();
      
      // Redimensiona (opcional)
      final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: 80);
      final ui.FrameInfo frame = await codec.getNextFrame();
      final ByteData? byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedBytes = byteData!.buffer.asUint8List();
      
      return BitmapDescriptor.fromBytes(resizedBytes);
    } catch (e) {
      print("Falha ao carregar ícone customizado, usando padrão");
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    }
  }

  void _showConfeitariaDetails(String id) {
    // Navega para tela de detalhes
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfeitariaDetailsScreen(confeitariaId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confeitarias Próximas'),
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
                zoom: 14,
              ),
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              compassEnabled: true,
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.gps_fixed),
        onPressed: () => _mapController.animateCamera(
          CameraUpdate.newLatLng(_initialPosition),
        ),
      ),
    );
  }
}

// Tela de detalhes (simplificada)
class ConfeitariaDetailsScreen extends StatelessWidget {
  final String confeitariaId;

  const ConfeitariaDetailsScreen({required this.confeitariaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes')),
      body: Center(child: Text('Confeitaria ID: $confeitariaId')),
    );
  }
}