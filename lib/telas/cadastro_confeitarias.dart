import 'dart:io';
import 'package:confeitaria_marketplace/database/app_database.dart';
import 'package:confeitaria_marketplace/telas/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;


class CadastrarConfeitaria extends StatefulWidget {
  final AppDatabase db;
  final Confeitaria? confeitaria;

  const CadastrarConfeitaria({
    super.key,
    required this.db,
    this.confeitaria,
  });

  @override
  State<CadastrarConfeitaria> createState() => _CadastrarConfeitariaState();
}

class _CadastrarConfeitariaState extends State<CadastrarConfeitaria> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _imagemSelecionada;
  final ImagePicker _picker = ImagePicker();
  final String _imagemPadraoPath = 'assets/images/logo.jpeg';
  // Controllers para os campos
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  // Controle de validação visual
  final Map<String, bool> _campoValido = {
    'nome': true,
    'telefone': true,
    'cep': true,
    'rua': true,
    'numero': true,
    'bairro': true,
    'cidade': true,
    'estado': true,
    'latitude': true,
    'longitude': true,
  };

  @override
  void initState() {
    super.initState();
    _carregarDadosExistente();
  }

  void _carregarDadosExistente() {
    final c = widget.confeitaria;
    if (c != null) {
      setState(() {
        _nomeController.text = c.nome;
        _telefoneController.text = c.telefone;
        _cepController.text = c.cep;
        _ruaController.text = c.rua;
        _numeroController.text = c.numero;
        _bairroController.text = c.bairro;
        _cidadeController.text = c.cidade;
        _estadoController.text = c.estado;
        _latitudeController.text = c.latitude.toString();
        _longitudeController.text = c.longitude.toString();
        if (c.imagemPath != null && c.imagemPath!.isNotEmpty) {
          _imagemSelecionada = File(c.imagemPath!);
        }
      });
    }
  }
  Future<void> _selecionarImagem() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }
  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _cepController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _limparTodosCampos() {
    setState(() {
      _nomeController.clear();
      _telefoneController.clear();
      _cepController.clear();
      _ruaController.clear();
      _numeroController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _estadoController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
      _formKey.currentState?.reset();

      // Reseta o estado de validação
      _campoValido.forEach((key, value) {
        _campoValido[key] = true;
      });
    });
  }
  Future<void> _mostrarOpcoesImagem() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Escolher da galeria'),
              onTap: () {
                Navigator.pop(context);
                _selecionarImagem();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Tirar foto'),
              onTap: () {
                Navigator.pop(context);
                _tirarFoto();
              },
            ),
            if (_imagemSelecionada != null)
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Remover imagem', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _imagemSelecionada = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
  Future<void> _salvarConfeitaria() async {
  // Reseta o estado de validação
  setState(() {
    _campoValido.forEach((key, value) {
      _campoValido[key] = true;
    });
  });

  if (!_formKey.currentState!.validate()) {
    setState(() {}); // Força rebuild para mostrar erros
    return;
  }

  setState(() => _isLoading = true);

  try {
    final confeitariaData = ConfeitariasCompanion(
      nome: drift.Value(_nomeController.text.trim()),
      telefone: drift.Value(_telefoneController.text.trim()),
      cep: drift.Value(_cepController.text.trim()),
      rua: drift.Value(_ruaController.text.trim()),
      numero: drift.Value(_numeroController.text.trim()),
      bairro: drift.Value(_bairroController.text.trim()),
      cidade: drift.Value(_cidadeController.text.trim()),
      estado: drift.Value(_estadoController.text.trim()),
      latitude: drift.Value(double.parse(_latitudeController.text)),
      longitude: drift.Value(double.parse(_longitudeController.text)),
      imagemPath: drift.Value(_imagemSelecionada?.path), // Novo campo da imagem
    );

    if (widget.confeitaria == null) {
      // NOVO CADASTRO
      await widget.db.into(widget.db.confeitarias).insert(confeitariaData).then((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Confeitaria cadastrada com sucesso!'),
              backgroundColor: Colors.green[800],
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ),
            ),
          ).closed.then((_) {
            _limparTodosCampos();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });
        }
      });
    } else {
      // EDIÇÃO
      final atualizada = Confeitaria(
        id: widget.confeitaria!.id,
        nome: confeitariaData.nome.value,
        telefone: confeitariaData.telefone.value,
        cep: confeitariaData.cep.value,
        rua: confeitariaData.rua.value,
        numero: confeitariaData.numero.value,
        bairro: confeitariaData.bairro.value,
        cidade: confeitariaData.cidade.value,
        estado: confeitariaData.estado.value,
        latitude: confeitariaData.latitude.value,
        longitude: confeitariaData.longitude.value,
        imagemPath: confeitariaData.imagemPath.value, // Novo campo da imagem
      );

      await widget.db.update(widget.db.confeitarias).replace(atualizada).then((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Confeitaria atualizada com sucesso!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          ).closed.then((_) {
            Navigator.pop(context, true); // Volta para a tela anterior
          });
        }
      });
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro: ${e.toString()}'),
        backgroundColor: Colors.red[800],
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

  Future<void> _confirmarExclusao() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Deseja realmente excluir esta confeitaria?'),
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
      setState(() => _isLoading = true);
      try {
        await widget.db.delete(widget.db.confeitarias).delete(widget.confeitaria!);
        if (!mounted) return;
        Navigator.pop(context, true); // Volta para a tela anterior após exclusão
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir: ${e.toString()}'),
            backgroundColor: Colors.red[800],
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 10) return 'Telefone inválido';
    return null;
  }

  String? _validateCEP(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length != 8) {
      return 'CEP inválido';
    }
    return null;
  }

  String? _validateEstado(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.confeitaria == null
            ? 'Cadastrar Confeitaria'
            : 'Editar Confeitaria'),
        
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _mostrarOpcoesImagem,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _imagemSelecionada != null
                              ? FileImage(_imagemSelecionada!)
                              : AssetImage(_imagemPadraoPath) as ImageProvider,
                          child: _imagemSelecionada == null
                              ? Icon(Icons.camera_alt, size: 40, color: Colors.purple)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _nomeController,
                        label: 'Nome da Confeitaria',
                        campoKey: 'nome',
                        maxLength: 30,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _telefoneController,
                        label: 'Telefone',
                        campoKey: 'telefone',
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        customValidator: _validatePhone,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _cepController,
                        label: 'CEP',
                        campoKey: 'cep',
                        keyboardType: TextInputType.number,
                        customValidator: _validateCEP,
                        maxLength: 8,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _ruaController,
                        label: 'Rua',
                        campoKey: 'rua',
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _numeroController,
                        label: 'Número',
                        campoKey: 'numero',
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _bairroController,
                        label: 'Bairro',
                        campoKey: 'bairro',
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildTextField(
                              controller: _cidadeController,
                              label: 'Cidade',
                              campoKey: 'cidade',
                              customValidator: _validateEstado,
                              maxLength: 30,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _estadoController,
                              label: 'UF',
                              campoKey: 'estado',
                              maxLength: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _latitudeController,
                              label: 'Latitude',
                              campoKey: 'latitude',
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _longitudeController,
                              label: 'Longitude',
                              campoKey: 'longitude',
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.location_on),
                            onPressed: _isLoading ? null : _obterLocalizacaoAtual,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),),
                          onPressed: _isLoading ? null : _salvarConfeitaria,
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  widget.confeitaria == null ? 'CADASTRAR' : 'SALVAR ALTERAÇÕES',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String campoKey,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? customValidator,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      enabled: !_isLoading,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: _campoValido[campoKey]! ? Colors.grey[50] : Colors.red[50],
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: label.endsWith('*')
            ? const Icon(Icons.star, size: 12, color: Colors.red)
            : null,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      validator: (value) {
        if (label.endsWith('*')) {
          if (value == null || value.isEmpty) {
            setState(() => _campoValido[campoKey] = false);
            return 'Campo obrigatório';
          }
        }
        final error = customValidator?.call(value);
        setState(() => _campoValido[campoKey] = error == null);
        return error;
      },
      onChanged: (value) {
        if (value.isNotEmpty && !_campoValido[campoKey]!) {
          setState(() => _campoValido[campoKey] = true);
        }
      },
    );
  }

  Future<void> _obterLocalizacaoAtual() async {
    setState(() => _isLoading = true);
    try {
      // Simulação - implemente com geolocator
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      setState(() {
        _latitudeController.text = '-23.550520';
        _longitudeController.text = '-46.633308';
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao obter localização: ${e.toString()}'),
          backgroundColor: Colors.red[800],
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}