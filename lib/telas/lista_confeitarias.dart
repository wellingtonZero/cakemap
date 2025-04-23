import 'dart:io';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/cadastro_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/detalhes_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/mapa_confeitarias.dart';
import 'package:flutter/material.dart';


class ListarConfeitarias extends StatefulWidget {
  final AppDatabase db;

  const ListarConfeitarias({super.key, required this.db});

  @override
  State<ListarConfeitarias> createState() => _ListarConfeitariasState();
}

class _ListarConfeitariasState extends State<ListarConfeitarias> {
  Future<void> _confirmarExclusaoConfeitaria(BuildContext context, Confeitaria confeitaria) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Deseja realmente excluir esta confeitaria e todos seus produtos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.db.deleteConfeitaria(confeitaria.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confeitaria excluída com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confeitarias Cadastradas'),
      ),
      body: StreamBuilder<List<Confeitaria>>(
        stream: widget.db.select(widget.db.confeitarias).watch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final confeitarias = snapshot.data ?? [];

          if (confeitarias.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nenhuma confeitaria cadastrada.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CadastrarConfeitaria(db: widget.db),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: const Text('Cadastrar Primeira Confeitaria'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: confeitarias.length,
            itemBuilder: (context, index) {
              final confeitaria = confeitarias[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalharConfeitaria(
                          db: widget.db,
                          confeitaria: confeitaria,
                        ),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: confeitaria.imagemPath != null && 
                                    confeitaria.imagemPath!.isNotEmpty
                        ? Image.file(File(confeitaria.imagemPath!)).image
                        : const AssetImage('assets/images/logo.jpeg'),
                  ),
                  title: Text(confeitaria.nome,style: TextStyle(fontSize: 19,color: Colors.purple, height: 1),),
                  subtitle: Text('${confeitaria.cidade} - ${confeitaria.estado}'),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_location_outlined, color: Colors.green, size: 30,),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapaConfeitaria(
                                db: widget.db,
                                confeitaria: confeitaria,
                              ),
                            ),
                          ).then((_) => setState(() {}));
                        },
                      ),
                      
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CadastrarConfeitaria(db: widget.db),
            ),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
    );
  }
}