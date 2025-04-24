import 'package:flutter/material.dart';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

class DetalharProduto extends StatefulWidget {
  final Produto produto;
  final AppDatabase db;

  const DetalharProduto({
    super.key,
    required this.produto,
    required this.db,
  });

  @override
  State<DetalharProduto> createState() => _DetalharProdutoState();
}

class _DetalharProdutoState extends State<DetalharProduto> {
  late Stream<List<String>> _imagensStream;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _imagensStream = widget.db.watchImagensProduto(widget.produto.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: StreamBuilder<List<String>>(
              stream: _imagensStream,
              builder: (context, snapshot) {
                final imagens = snapshot.data ?? [];
                
                if (imagens.isEmpty) {
                  return Image.asset(
                    'assets/images/logo.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: CarouselSlider.builder(
                        itemCount: imagens.length,
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() => _currentImageIndex = index);
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Hero(
                            tag: 'produto-imagem-${widget.produto.id}-$index',
                            child: Image.file(
                              File(imagens[index]),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                    if (imagens.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imagens.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == entry.key
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                );
              },
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
                    widget.produto.nome,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$ ${widget.produto.preco.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.produto.descricao != null && 
                      widget.produto.descricao!.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.produto.descricao!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
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