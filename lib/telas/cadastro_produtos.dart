import 'package:confeitaria_marketplace/telas/listar_produtos.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:confeitaria_marketplace/database/app_database.dart';


class CadastrarProdutos extends StatefulWidget {
  final AppDatabase db;
  final Confeitaria confeitaria;
  final Produto? produtoParaEdicao;

  const CadastrarProdutos({
    super.key,
    required this.db,
    required this.confeitaria,
    this.produtoParaEdicao,
  });

  @override
  State<CadastrarProdutos> createState() => _CadastrarProdutosState();
}

class _CadastrarProdutosState extends State<CadastrarProdutos> {
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;
  final List<File> _imagensSelecionadas = [];
  Produto? _produtoEmEdicao;
  List<String> _imagensExistentes = [];


  @override
  void initState() {
    super.initState();
    if (widget.produtoParaEdicao != null) {
      _editarProduto(widget.produtoParaEdicao!);
      _carregarImagensExistentes();
    }
  }

  Future<void> _carregarImagensExistentes() async {
    if (_produtoEmEdicao == null) return;

    final imagens = await widget.db.getImagensProduto(_produtoEmEdicao!.id);
    setState(() {
      _imagensExistentes = imagens;
    });
  }

  Future<void> _adicionarProduto() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final produtoData = ProdutosCompanion(
        id: _produtoEmEdicao != null
            ? drift.Value(_produtoEmEdicao!.id)
            : const drift.Value.absent(),
        confeitariaId: drift.Value(widget.confeitaria.id),
        nome: drift.Value(_nomeController.text.trim()),
        preco: drift.Value(double.parse(_precoController.text)),
        descricao: drift.Value(_descricaoController.text.trim()),
      );

      int produtoId;
      if (_produtoEmEdicao == null) {
        produtoId =
            await widget.db.into(widget.db.produtos).insert(produtoData);
      } else {
        produtoId = _produtoEmEdicao!.id;
        await widget.db.update(widget.db.produtos).replace(
              Produto(
                id: _produtoEmEdicao!.id,
                confeitariaId: widget.confeitaria.id,
                nome: produtoData.nome.value,
                preco: produtoData.preco.value,
                descricao: produtoData.descricao.value,
              ),
            );
      }

      // Salvar novas imagens
      for (final imagem in _imagensSelecionadas) {
        await widget.db.into(widget.db.produtoImagens).insert(
              ProdutoImagensCompanion(
                produtoId: drift.Value(produtoId),
                imagemPath: drift.Value(imagem.path),
              ),
            );
      }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _produtoEmEdicao == null
                ? 'Produto adicionado com sucesso!'
                : 'Produto atualizado com sucesso!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      _limparCampos();
      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _selecionarImagens() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imagensSelecionadas.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> _tirarFoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imagensSelecionadas.add(File(pickedFile.path)));
    }
  }

  Future<void> _removerImagem(int index, {bool isExisting = false}) async {
    if (isExisting) {
      final imagemPath = _imagensExistentes[index];
      final query = widget.db.delete(widget.db.produtoImagens);
      query.where((tbl) => tbl.imagemPath.equals(imagemPath));
      await query.go();
      setState(() => _imagensExistentes.removeAt(index));
    } else {
      setState(() => _imagensSelecionadas.removeAt(index));
    }
  }

  Widget _buildImagemPreview(File file, int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(file),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 15,
          child: GestureDetector(
            onTap: () => _removerImagem(index),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExistingImagem(String path, int index) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 15,
          child: GestureDetector(
            onTap: () => _removerImagem(index, isExisting: true),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _navegarParaListaProdutos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListarProdutos(
          db: widget.db,
          confeitaria: widget.confeitaria,
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${_produtoEmEdicao == null ? 'Adicionar' : 'Editar'} Produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Imagens do Produto',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Imagens existentes
              if (_imagensExistentes.isNotEmpty) ...[
                const Text('Imagens atuais:',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagensExistentes.length,
                    itemBuilder: (context, index) {
                      return _buildExistingImagem(
                          _imagensExistentes[index], index);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // Novas imagens selecionadas
              if (_imagensSelecionadas.isNotEmpty) ...[
                const Text('Novas imagens:',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagensSelecionadas.length,
                    itemBuilder: (context, index) {
                      return _buildImagemPreview(
                          _imagensSelecionadas[index], index);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              // Botões para adicionar imagens
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _selecionarImagens,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeria'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _tirarFoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Câmera'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Demais campos do formulário
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _precoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Campo obrigatório';
                  if (double.tryParse(value!) == null) return 'Valor inválido';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 25),

              // Botão de salvar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _adicionarProduto,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(_produtoEmEdicao == null
                          ? 'SALVAR PRODUTO'
                          : 'ATUALIZAR PRODUTO'),
                ),
              ),
              
              // Botão para listar produtos
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _navegarParaListaProdutos,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('EDITAR PRODUTOS'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _editarProduto(Produto produto) {
    setState(() {
      _produtoEmEdicao = produto;
      _nomeController.text = produto.nome;
      _precoController.text = produto.preco.toString();
      _descricaoController.text = produto.descricao ?? '';
    });
  }

  void _limparCampos() {
    _nomeController.clear();
    _precoController.clear();
    _descricaoController.clear();
    setState(() {
      _imagensSelecionadas.clear();
      _produtoEmEdicao = null;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }
}