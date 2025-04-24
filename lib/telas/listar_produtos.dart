import 'dart:io';
import 'package:flutter/material.dart';
import 'package:confeitaria_marketplace/telas/cadastro_produtos.dart';
import 'package:confeitaria_marketplace/database/app_database.dart';

class ListarProdutos extends StatefulWidget {
  final AppDatabase db;
  final Confeitaria confeitaria;

  const ListarProdutos({
    super.key,
    required this.db,
    required this.confeitaria,
  });

  @override
  State<ListarProdutos> createState() => _ListarProdutosState();
}

class _ListarProdutosState extends State<ListarProdutos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos - ${widget.confeitaria.nome}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _abrirTelaCadastroProduto(null),
          ),
        ],
      ),
      body: StreamBuilder<List<Produto>>(
        stream: widget.db.watchProdutosDaConfeitaria(widget.confeitaria.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum produto cadastrado'),
            );
          }

          final produtos = snapshot.data!;
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return _buildProdutoItem(produto);
            },
          );
        },
      ),
    );
  }

  Widget _buildProdutoItem(Produto produto) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Ícone/Imagem do produto
            FutureBuilder<List<String>>(
              future: widget.db.getImagensProduto(produto.id),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(File(snapshot.data!.first)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.cake, color: Colors.grey),
                );
              },
            ),
            const SizedBox(width: 12),

            // Informações do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$${produto.preco.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (produto.descricao != null && produto.descricao!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        produto.descricao!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Botões de ação
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _abrirTelaCadastroProduto(produto),
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmarExclusao(produto),
                  tooltip: 'Excluir',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _abrirTelaCadastroProduto(Produto? produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastrarProdutos(
          db: widget.db,
          confeitaria: widget.confeitaria,
          produtoParaEdicao: produto,
        ),
      ),
    ).then((_) => setState(() {}));
  }

  void _confirmarExclusao(Produto produto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text('Deseja realmente excluir "${produto.nome}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _excluirProduto(produto);
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _excluirProduto(Produto produto) async {
    try {
      await widget.db.transaction(() async {
        // Primeiro exclui as imagens associadas
        await (widget.db.delete(widget.db.produtoImagens)
              ..where((tbl) => tbl.produtoId.equals(produto.id)))
            .go();
        
        // Depois exclui o produto
        await (widget.db.delete(widget.db.produtos)
              ..where((tbl) => tbl.id.equals(produto.id)))
            .go();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${produto.nome}" excluído com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}