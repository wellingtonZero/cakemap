
import 'package:confeitaria_marketplace/telas/lista_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/mapa_confeitarias.dart';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<AppDatabase> _dbFuture;

  @override
  void initState() {
    super.initState();
    _dbFuture = _initializeDatabase();
  }

  Future<AppDatabase> _initializeDatabase() async {
    await Future.delayed(const Duration(milliseconds: 1500)); // Simula carga
    return AppDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo ao CakeMap!'),
        centerTitle: true,
      ),
      body: FutureBuilder<AppDatabase>(
        future: _dbFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _buildErrorWidget(context, snapshot.error!);
          }

          final db = snapshot.data!;
          return _buildMainContent(context, db);
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, AppDatabase db) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            context,
            icon: Icons.map,
            label: 'Mapa',
            destination: const MapaConfeitaria(),
          ),
          const SizedBox(height: 20),
          _buildActionButton(
            context,
            icon: Icons.list,
            label: 'Confeitarias',
            destination: ListarConfeitarias(db: db),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 50),
          const SizedBox(height: 20),
          Text(
            'Erro ao inicializar: ${error.toString()}',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => setState(() {
              _dbFuture = _initializeDatabase();
            }),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget destination,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
        icon: Icon(icon, size: 30),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        onPressed: () => _navigateTo(context, destination),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}