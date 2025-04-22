import 'dart:io';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:flutter/material.dart';

class DetalharProduto extends StatelessWidget {
  final Produto produto;

  const DetalharProduto({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Hero(
              tag: 'produto-imagem-${produto.id}',
              child: produto.imagemPath != null && produto.imagemPath!.isNotEmpty
                  ? Image.file(
                      File(produto.imagemPath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nome,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$ ${produto.preco.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (produto.descricao != null && produto.descricao!.isNotEmpty)
                    Text(
                      produto.descricao!,
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}