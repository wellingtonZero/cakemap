import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/detalhes_produtos.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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
  File? _imagemSelecionada;
  final ImagePicker _picker = ImagePicker();
  final String _imagemPadraoPath = 'assets/images/logo.jpeg';
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool _mostrarFormulario = false;
  Produto? _produtoEmEdicao;

  @override
  void initState() {
    super.initState();
    if (widget.produtoParaEdicao != null) {
      _editarProduto(widget.produtoParaEdicao!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
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
        imagemPath: drift.Value(_imagemSelecionada?.path),
      );

      if (_produtoEmEdicao == null) {
        // NOVO PRODUTO
        await widget.db.into(widget.db.produtos).insert(produtoData);
      } else {
        // EDIÇÃO
        await widget.db.update(widget.db.produtos).replace(
              Produto(
                id: _produtoEmEdicao!.id,
                confeitariaId: widget.confeitaria.id,
                nome: produtoData.nome.value,
                preco: produtoData.preco.value,
                descricao: produtoData.descricao.value,
                imagemPath: produtoData.imagemPath.value,
              ),
            );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _produtoEmEdicao == null
                ? 'Produto adicionado com sucesso!'
                : 'Produto atualizado com sucesso!',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      _limparCampos();
      if (_produtoEmEdicao != null) {
        Navigator.pop(context, true);
      } else {
        _toggleFormulario();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString()}'),
          backgroundColor: Colors.red[800],
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _limparCampos() {
    _nomeController.clear();
    _precoController.clear();
    _descricaoController.clear();
    setState(() {
      _imagemSelecionada = null;
      _produtoEmEdicao = null;
    });
  }

  void _toggleFormulario() {
    setState(() {
      _mostrarFormulario = !_mostrarFormulario;
      if (!_mostrarFormulario) {
        _limparCampos();
        FocusScope.of(context).unfocus();
      }
    });
  }

  Future<void> _selecionarImagem() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imagemSelecionada = File(pickedFile.path));
    }
  }

  Future<void> _tirarFoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _imagemSelecionada = File(pickedFile.path));
    }
  }

  Future<void> _mostrarOpcoesImagem() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Escolher da galeria'),
              onTap: () {
                Navigator.pop(context);
                _selecionarImagem();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tirar foto'),
              onTap: () {
                Navigator.pop(context);
                _tirarFoto();
              },
            ),
            if (_imagemSelecionada != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remover imagem', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _imagemSelecionada = null);
                },
              ),
          ],
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
      if (produto.imagemPath != null && produto.imagemPath!.isNotEmpty) {
        _imagemSelecionada = File(produto.imagemPath!);
      } else {
        _imagemSelecionada = null;
      }
      _mostrarFormulario = true;
    });

    // Rola para o topo para mostrar o formulário
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _confirmarExclusaoProduto(Produto produto) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Deseja realmente excluir este produto?',style:TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar',style: TextStyle(color: Colors.black,fontSize: 18)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red,fontSize:18)),
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Produtos - ${widget.confeitaria.nome}'),
        actions: [
          if (!_mostrarFormulario)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => setState(() {}),
            ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            if (!_mostrarFormulario && _produtoEmEdicao == null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _toggleFormulario,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'ADICIONAR PRODUTO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            if (_mostrarFormulario || _produtoEmEdicao != null)
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          _produtoEmEdicao == null ? 'ADICIONAR PRODUTO' : 'EDITAR PRODUTO',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _mostrarOpcoesImagem,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _imagemSelecionada != null
                                ? FileImage(_imagemSelecionada!)
                                : AssetImage(_imagemPadraoPath) as ImageProvider,
                            child: _imagemSelecionada == null
                                ? const Icon(Icons.camera_alt, size: 30, color: Colors.purple)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nomeController,
                          decoration: const InputDecoration(
                            labelText: 'Nome do produto*',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _precoController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Preço*',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Campo obrigatório';
                            if (double.tryParse(value) == null) return 'Digite um valor válido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _descricaoController,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _adicionarProduto,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  _produtoEmEdicao == null ? 'SALVAR PRODUTO' : 'ATUALIZAR PRODUTO',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        if (_produtoEmEdicao != null)
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    _limparCampos();
                                    Navigator.pop(context);
                                  },
                            child: const Text('Cancelar'),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            if (!_mostrarFormulario && _produtoEmEdicao == null)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'PRODUTOS CADASTRADOS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            if (!_mostrarFormulario || _produtoEmEdicao != null)
              Expanded(
                child: StreamBuilder<List<Produto>>(
                  stream: widget.db.watchProdutosDaConfeitaria(widget.confeitaria.id),
                  builder: (context, snapshot) {
                    final produtos = snapshot.data ?? [];

                    if (produtos.isEmpty) {
                      return Center(
                        child: Text(
                          _mostrarFormulario ? 'Adicione seu primeiro produto' : 'Nenhum produto cadastrado',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetalharProduto(
                                      produto: produto,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'produto-imagem-${produto.id}',
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: produto.imagemPath != null &&
                                          produto.imagemPath!.isNotEmpty
                                      ? FileImage(File(produto.imagemPath!))
                                      : AssetImage(_imagemPadraoPath) as ImageProvider,
                                ),
                              ),
                            ),
                            title: Text(produto.nome,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.green, fontWeight: FontWeight.bold),
                                ),
                                if (produto.descricao != null && produto.descricao!.isNotEmpty)
                                  Text(produto.descricao!,
                                      style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editarProduto(produto),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _confirmarExclusaoProduto(produto);
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
              ),
          ],
        ),
      ),
    );
  }
}