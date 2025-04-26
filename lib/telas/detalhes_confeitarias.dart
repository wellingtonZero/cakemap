import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/cadastro_confeitarias.dart';
import 'package:confeitaria_marketplace/telas/cadastro_produtos.dart';
import 'package:confeitaria_marketplace/telas/detalhes_produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';

class DetalharConfeitaria extends StatefulWidget {
  final AppDatabase db;
  final Confeitaria confeitaria;

  const DetalharConfeitaria({
    super.key,
    required this.db,
    required this.confeitaria,
  });

  @override
  State<DetalharConfeitaria> createState() => _DetalharConfeitariaState();
}

class _DetalharConfeitariaState extends State<DetalharConfeitaria> {
  Future<void> _confirmarExclusaoProduto(
      BuildContext context, Produto produto) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Deseja realmente excluir este produto?'),
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
      await widget.db.delete(widget.db.produtos).delete(produto);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _confirmarExclusaoConfeitaria(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão', style: TextStyle(fontSize: 20)),
        content: const Text(
            'Deseja realmente excluir esta confeitaria e todos seus produtos?',
            style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir',
                style: TextStyle(color: Colors.red, fontSize: 18)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.db.deleteConfeitaria(widget.confeitaria.id);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confeitaria excluída com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Widget _buildImagemConfeitaria() {
    try {
      if (widget.confeitaria.imagemPath != null &&
          File(widget.confeitaria.imagemPath!).existsSync()) {
        return Image.file(
          File(widget.confeitaria.imagemPath!),
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      debugPrint('Erro ao carregar imagem: $e');
    }
    return Image.asset(
      'assets/images/logo.jpeg',
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.confeitaria.nome,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  
                  height: 1.0,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.purple,
                      offset: Offset(1.0, 1.0),
                    )
                  ],
                ),
              ),
              background: _buildImagemConfeitaria(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        widget.confeitaria.telefone,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 19),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${widget.confeitaria.cidade} - ${widget.confeitaria.estado}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${widget.confeitaria.rua}, ${widget.confeitaria.numero} - ${widget.confeitaria.bairro}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Produtos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          StreamBuilder<List<Produto>>(
            stream: widget.db.watchProdutosDaConfeitaria(widget.confeitaria.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final produtos = snapshot.data!;

              if (produtos.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Nenhum produto cadastrado')),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final produto = produtos[index];
                      return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Editar'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CadastrarProdutos(
                                            db: widget.db,
                                            confeitaria: widget.confeitaria,
                                            produtoParaEdicao: produto,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.delete,
                                        color: Colors.red),
                                    title: const Text('Excluir',
                                        style: TextStyle(color: Colors.red)),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _confirmarExclusaoProduto(context, produto);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetalharProduto(
                                            produto: produto,
                                            db: widget.db,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: 'produto-imagem-${produto.id}',
                                      child: StreamBuilder<List<String>>(
                                        stream: widget.db.watchImagensProduto(produto.id),
                                        builder: (context, snapshot) {
                                          final imagens = snapshot.data ?? [];
                                          return imagens.isNotEmpty
                                              ? Image.file(
                                                  File(imagens.first),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/logo.jpeg',
                                                  fit: BoxFit.cover,
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      produto.nome,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'R\$ ${produto.preco.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: produtos.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        foregroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green,
            label: 'Adicionar Produto',
            labelStyle: const TextStyle(fontSize: 16.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CadastrarProdutos(
                    db: widget.db,
                    confeitaria: widget.confeitaria,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit, color: Colors.white),
            backgroundColor: Colors.blue,
            label: 'Editar Confeitaria',
            labelStyle: const TextStyle(fontSize: 16.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CadastrarConfeitaria(
                    db: widget.db,
                    confeitaria: widget.confeitaria,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete, color: Colors.white),
            backgroundColor: Colors.red,
            label: 'Excluir Confeitaria',
            labelStyle: const TextStyle(fontSize: 16.0),
            onTap: () => _confirmarExclusaoConfeitaria(context),
          ),
        ],
      ),
    );
  }
}