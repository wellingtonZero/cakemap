import 'package:flutter/material.dart';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/lista_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/cadastro_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/mapa_confeitarias.dart';

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
    await Future.delayed(const Duration(milliseconds: 500));
    return AppDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CakeMap'),
        centerTitle: true,
        elevation: 0,
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
          // Logo ou imagem principal
          Image.asset(
            'assets/images/cupcake.png',
            height: 150,
          ),
          const SizedBox(height: 40),
          // Botão para Cadastrar Nova
          _buildActionButton(
            context,
            icon: Icons.add_business,
            label: 'Cadastrar Confeitaria',
            onPressed: () => _navigateTo(context, CadastrarConfeitaria(db: db)),
          ),
          const SizedBox(height: 20),
          // Botão para Listar Confeitarias
          _buildActionButton(
            context,
            icon: Icons.list_alt,
            label: 'Listar Confeitarias',
            onPressed: () => _navigateTo(context, ListarConfeitarias(db: db)),
          ),
          const SizedBox(height: 20),

          // Botão para Ver no Mapa
          _buildActionButton(
            context,
            icon: Icons.map_outlined,
            label: 'Ver no Mapa',
            onPressed: () => _navigateTo(context, MapaConfeitaria(db: db)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[50],
          foregroundColor: Colors.purple[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.purple[300]!),
          ),
          elevation: 2,
        ),
        icon: Icon(icon, size: 30),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => destination),
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
}
