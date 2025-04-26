import 'dart:io';
import 'package:flutter/material.dart';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/lista_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/cadastro_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/mapa_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/detalhes_confeitarias.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<AppDatabase> _dbFuture;
  int _currentPageIndex = 0;
  late List<Widget> _pages;

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
    return FutureBuilder<AppDatabase>(
      future: _dbFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorWidget(context, snapshot.error!);
        }

        final db = snapshot.data!;
        _pages = [
          _buildHomeContent(db),
          ListarConfeitarias(db: db),
          CadastrarConfeitaria(db: db),
          MapaConfeitaria(db: db),
        ];

        return Scaffold(
          appBar: _currentPageIndex == 0 
              ? AppBar(
                  title: const Text('CakeMap'),
                  centerTitle: true,
                  elevation: 0,
                )
              : AppBar(
                  title: Text(_getAppBarTitle()),
                  centerTitle: true,
                  elevation: 0,
                ),
          body: _pages[_currentPageIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            backgroundColor: Colors.purple[50],
            indicatorColor: Colors.purple[100],
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Início',
              ),
              NavigationDestination(
                icon: Icon(Icons.list_alt_outlined),
                selectedIcon: Icon(Icons.list_alt),
                label: 'Lista',
              ),
               NavigationDestination(
                icon: Icon(Icons.add_business_outlined),
                selectedIcon: Icon(Icons.add_business),
                label: 'Cadastrar',
              ),
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: 'Mapa',
              ),
            ],
          ),
        );
      },
    );
  }

  String _getAppBarTitle() {
    switch (_currentPageIndex) {
      case 1:
        return 'Lista de Confeitarias';
      case 2:
        return 'Confeitaria';
      case 3:
        return 'Confeitarias no Mapa';
      default:
        return 'CakeMap';
    }
  }

  Widget _buildHomeContent(AppDatabase db) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildConfeitariasCarousel(db),
          const SizedBox(height: 40),
          Image.asset(
            'assets/images/cupcake.png',
            height: 150,
          ),
          const SizedBox(height: 20),
          Text(
            'Bem-vindo ao CakeMap!',
            style: TextStyle(
              fontSize: 24,
              color: Colors.purple[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Encontre as melhores confeitarias da sua região',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple[600],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildConfeitariasCarousel(AppDatabase db) {
    return SizedBox(
      height: 200,
      child: StreamBuilder<List<Confeitaria>>(
        stream: db.select(db.confeitarias).watch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final confeitarias = snapshot.data ?? [];

          if (confeitarias.isEmpty) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CadastrarConfeitaria(db: db),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/cupcake.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: confeitarias.length,
            itemBuilder: (context, index) {
              final confeitaria = confeitarias[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalharConfeitaria(
                        db: db,
                        confeitaria: confeitaria,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Imagem da confeitaria
                          confeitaria.imagemPath != null && 
                              confeitaria.imagemPath!.isNotEmpty
                              ? Image.file(
                                  File(confeitaria.imagemPath!),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/logo.jpeg',
                                  fit: BoxFit.cover,
                                ),
                          // Gradiente escuro na parte inferior
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Nome e localização
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  confeitaria.nome,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${confeitaria.cidade} - ${confeitaria.estado}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro')),
      body: Center(
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
      ),
    );
  }
}