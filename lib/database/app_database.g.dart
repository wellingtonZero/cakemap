// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ConfeitariasTable extends Confeitarias
    with TableInfo<$ConfeitariasTable, Confeitaria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfeitariasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _cepMeta = const VerificationMeta('cep');
  @override
  late final GeneratedColumn<String> cep = GeneratedColumn<String>(
      'cep', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ruaMeta = const VerificationMeta('rua');
  @override
  late final GeneratedColumn<String> rua = GeneratedColumn<String>(
      'rua', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bairroMeta = const VerificationMeta('bairro');
  @override
  late final GeneratedColumn<String> bairro = GeneratedColumn<String>(
      'bairro', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagemPathMeta =
      const VerificationMeta('imagemPath');
  @override
  late final GeneratedColumn<String> imagemPath = GeneratedColumn<String>(
      'imagem_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nome,
        latitude,
        longitude,
        cep,
        rua,
        numero,
        bairro,
        cidade,
        estado,
        telefone,
        imagemPath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'confeitarias';
  @override
  VerificationContext validateIntegrity(Insertable<Confeitaria> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('cep')) {
      context.handle(
          _cepMeta, cep.isAcceptableOrUnknown(data['cep']!, _cepMeta));
    } else if (isInserting) {
      context.missing(_cepMeta);
    }
    if (data.containsKey('rua')) {
      context.handle(
          _ruaMeta, rua.isAcceptableOrUnknown(data['rua']!, _ruaMeta));
    } else if (isInserting) {
      context.missing(_ruaMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('bairro')) {
      context.handle(_bairroMeta,
          bairro.isAcceptableOrUnknown(data['bairro']!, _bairroMeta));
    } else if (isInserting) {
      context.missing(_bairroMeta);
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    } else if (isInserting) {
      context.missing(_cidadeMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    } else if (isInserting) {
      context.missing(_telefoneMeta);
    }
    if (data.containsKey('imagem_path')) {
      context.handle(
          _imagemPathMeta,
          imagemPath.isAcceptableOrUnknown(
              data['imagem_path']!, _imagemPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Confeitaria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Confeitaria(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      cep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cep'])!,
      rua: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rua'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      bairro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bairro'])!,
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone'])!,
      imagemPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagem_path']),
    );
  }

  @override
  $ConfeitariasTable createAlias(String alias) {
    return $ConfeitariasTable(attachedDatabase, alias);
  }
}

class Confeitaria extends DataClass implements Insertable<Confeitaria> {
  final int id;
  final String nome;
  final double latitude;
  final double longitude;
  final String cep;
  final String rua;
  final String numero;
  final String bairro;
  final String cidade;
  final String estado;
  final String telefone;
  final String? imagemPath;
  const Confeitaria(
      {required this.id,
      required this.nome,
      required this.latitude,
      required this.longitude,
      required this.cep,
      required this.rua,
      required this.numero,
      required this.bairro,
      required this.cidade,
      required this.estado,
      required this.telefone,
      this.imagemPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['cep'] = Variable<String>(cep);
    map['rua'] = Variable<String>(rua);
    map['numero'] = Variable<String>(numero);
    map['bairro'] = Variable<String>(bairro);
    map['cidade'] = Variable<String>(cidade);
    map['estado'] = Variable<String>(estado);
    map['telefone'] = Variable<String>(telefone);
    if (!nullToAbsent || imagemPath != null) {
      map['imagem_path'] = Variable<String>(imagemPath);
    }
    return map;
  }

  ConfeitariasCompanion toCompanion(bool nullToAbsent) {
    return ConfeitariasCompanion(
      id: Value(id),
      nome: Value(nome),
      latitude: Value(latitude),
      longitude: Value(longitude),
      cep: Value(cep),
      rua: Value(rua),
      numero: Value(numero),
      bairro: Value(bairro),
      cidade: Value(cidade),
      estado: Value(estado),
      telefone: Value(telefone),
      imagemPath: imagemPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagemPath),
    );
  }

  factory Confeitaria.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Confeitaria(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      cep: serializer.fromJson<String>(json['cep']),
      rua: serializer.fromJson<String>(json['rua']),
      numero: serializer.fromJson<String>(json['numero']),
      bairro: serializer.fromJson<String>(json['bairro']),
      cidade: serializer.fromJson<String>(json['cidade']),
      estado: serializer.fromJson<String>(json['estado']),
      telefone: serializer.fromJson<String>(json['telefone']),
      imagemPath: serializer.fromJson<String?>(json['imagemPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'cep': serializer.toJson<String>(cep),
      'rua': serializer.toJson<String>(rua),
      'numero': serializer.toJson<String>(numero),
      'bairro': serializer.toJson<String>(bairro),
      'cidade': serializer.toJson<String>(cidade),
      'estado': serializer.toJson<String>(estado),
      'telefone': serializer.toJson<String>(telefone),
      'imagemPath': serializer.toJson<String?>(imagemPath),
    };
  }

  Confeitaria copyWith(
          {int? id,
          String? nome,
          double? latitude,
          double? longitude,
          String? cep,
          String? rua,
          String? numero,
          String? bairro,
          String? cidade,
          String? estado,
          String? telefone,
          Value<String?> imagemPath = const Value.absent()}) =>
      Confeitaria(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        cep: cep ?? this.cep,
        rua: rua ?? this.rua,
        numero: numero ?? this.numero,
        bairro: bairro ?? this.bairro,
        cidade: cidade ?? this.cidade,
        estado: estado ?? this.estado,
        telefone: telefone ?? this.telefone,
        imagemPath: imagemPath.present ? imagemPath.value : this.imagemPath,
      );
  Confeitaria copyWithCompanion(ConfeitariasCompanion data) {
    return Confeitaria(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      cep: data.cep.present ? data.cep.value : this.cep,
      rua: data.rua.present ? data.rua.value : this.rua,
      numero: data.numero.present ? data.numero.value : this.numero,
      bairro: data.bairro.present ? data.bairro.value : this.bairro,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      estado: data.estado.present ? data.estado.value : this.estado,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      imagemPath:
          data.imagemPath.present ? data.imagemPath.value : this.imagemPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Confeitaria(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('cep: $cep, ')
          ..write('rua: $rua, ')
          ..write('numero: $numero, ')
          ..write('bairro: $bairro, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('telefone: $telefone, ')
          ..write('imagemPath: $imagemPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, latitude, longitude, cep, rua,
      numero, bairro, cidade, estado, telefone, imagemPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Confeitaria &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.cep == this.cep &&
          other.rua == this.rua &&
          other.numero == this.numero &&
          other.bairro == this.bairro &&
          other.cidade == this.cidade &&
          other.estado == this.estado &&
          other.telefone == this.telefone &&
          other.imagemPath == this.imagemPath);
}

class ConfeitariasCompanion extends UpdateCompanion<Confeitaria> {
  final Value<int> id;
  final Value<String> nome;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> cep;
  final Value<String> rua;
  final Value<String> numero;
  final Value<String> bairro;
  final Value<String> cidade;
  final Value<String> estado;
  final Value<String> telefone;
  final Value<String?> imagemPath;
  const ConfeitariasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.cep = const Value.absent(),
    this.rua = const Value.absent(),
    this.numero = const Value.absent(),
    this.bairro = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.telefone = const Value.absent(),
    this.imagemPath = const Value.absent(),
  });
  ConfeitariasCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required double latitude,
    required double longitude,
    required String cep,
    required String rua,
    required String numero,
    required String bairro,
    required String cidade,
    required String estado,
    required String telefone,
    this.imagemPath = const Value.absent(),
  })  : nome = Value(nome),
        latitude = Value(latitude),
        longitude = Value(longitude),
        cep = Value(cep),
        rua = Value(rua),
        numero = Value(numero),
        bairro = Value(bairro),
        cidade = Value(cidade),
        estado = Value(estado),
        telefone = Value(telefone);
  static Insertable<Confeitaria> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? cep,
    Expression<String>? rua,
    Expression<String>? numero,
    Expression<String>? bairro,
    Expression<String>? cidade,
    Expression<String>? estado,
    Expression<String>? telefone,
    Expression<String>? imagemPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (cep != null) 'cep': cep,
      if (rua != null) 'rua': rua,
      if (numero != null) 'numero': numero,
      if (bairro != null) 'bairro': bairro,
      if (cidade != null) 'cidade': cidade,
      if (estado != null) 'estado': estado,
      if (telefone != null) 'telefone': telefone,
      if (imagemPath != null) 'imagem_path': imagemPath,
    });
  }

  ConfeitariasCompanion copyWith(
      {Value<int>? id,
      Value<String>? nome,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String>? cep,
      Value<String>? rua,
      Value<String>? numero,
      Value<String>? bairro,
      Value<String>? cidade,
      Value<String>? estado,
      Value<String>? telefone,
      Value<String?>? imagemPath}) {
    return ConfeitariasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cep: cep ?? this.cep,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      telefone: telefone ?? this.telefone,
      imagemPath: imagemPath ?? this.imagemPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (cep.present) {
      map['cep'] = Variable<String>(cep.value);
    }
    if (rua.present) {
      map['rua'] = Variable<String>(rua.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (bairro.present) {
      map['bairro'] = Variable<String>(bairro.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (imagemPath.present) {
      map['imagem_path'] = Variable<String>(imagemPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfeitariasCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('cep: $cep, ')
          ..write('rua: $rua, ')
          ..write('numero: $numero, ')
          ..write('bairro: $bairro, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('telefone: $telefone, ')
          ..write('imagemPath: $imagemPath')
          ..write(')'))
        .toString();
  }
}

class $ProdutosTable extends Produtos with TableInfo<$ProdutosTable, Produto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdutosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _confeitariaIdMeta =
      const VerificationMeta('confeitariaId');
  @override
  late final GeneratedColumn<int> confeitariaId = GeneratedColumn<int>(
      'confeitaria_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES confeitarias (id)'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _precoMeta = const VerificationMeta('preco');
  @override
  late final GeneratedColumn<double> preco = GeneratedColumn<double>(
      'preco', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, confeitariaId, nome, preco, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produtos';
  @override
  VerificationContext validateIntegrity(Insertable<Produto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('confeitaria_id')) {
      context.handle(
          _confeitariaIdMeta,
          confeitariaId.isAcceptableOrUnknown(
              data['confeitaria_id']!, _confeitariaIdMeta));
    } else if (isInserting) {
      context.missing(_confeitariaIdMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('preco')) {
      context.handle(
          _precoMeta, preco.isAcceptableOrUnknown(data['preco']!, _precoMeta));
    } else if (isInserting) {
      context.missing(_precoMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Produto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Produto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      confeitariaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}confeitaria_id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      preco: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}preco'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
    );
  }

  @override
  $ProdutosTable createAlias(String alias) {
    return $ProdutosTable(attachedDatabase, alias);
  }
}

class Produto extends DataClass implements Insertable<Produto> {
  final int id;
  final int confeitariaId;
  final String nome;
  final double preco;
  final String? descricao;
  const Produto(
      {required this.id,
      required this.confeitariaId,
      required this.nome,
      required this.preco,
      this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['confeitaria_id'] = Variable<int>(confeitariaId);
    map['nome'] = Variable<String>(nome);
    map['preco'] = Variable<double>(preco);
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    return map;
  }

  ProdutosCompanion toCompanion(bool nullToAbsent) {
    return ProdutosCompanion(
      id: Value(id),
      confeitariaId: Value(confeitariaId),
      nome: Value(nome),
      preco: Value(preco),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
    );
  }

  factory Produto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Produto(
      id: serializer.fromJson<int>(json['id']),
      confeitariaId: serializer.fromJson<int>(json['confeitariaId']),
      nome: serializer.fromJson<String>(json['nome']),
      preco: serializer.fromJson<double>(json['preco']),
      descricao: serializer.fromJson<String?>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'confeitariaId': serializer.toJson<int>(confeitariaId),
      'nome': serializer.toJson<String>(nome),
      'preco': serializer.toJson<double>(preco),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  Produto copyWith(
          {int? id,
          int? confeitariaId,
          String? nome,
          double? preco,
          Value<String?> descricao = const Value.absent()}) =>
      Produto(
        id: id ?? this.id,
        confeitariaId: confeitariaId ?? this.confeitariaId,
        nome: nome ?? this.nome,
        preco: preco ?? this.preco,
        descricao: descricao.present ? descricao.value : this.descricao,
      );
  Produto copyWithCompanion(ProdutosCompanion data) {
    return Produto(
      id: data.id.present ? data.id.value : this.id,
      confeitariaId: data.confeitariaId.present
          ? data.confeitariaId.value
          : this.confeitariaId,
      nome: data.nome.present ? data.nome.value : this.nome,
      preco: data.preco.present ? data.preco.value : this.preco,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Produto(')
          ..write('id: $id, ')
          ..write('confeitariaId: $confeitariaId, ')
          ..write('nome: $nome, ')
          ..write('preco: $preco, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, confeitariaId, nome, preco, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Produto &&
          other.id == this.id &&
          other.confeitariaId == this.confeitariaId &&
          other.nome == this.nome &&
          other.preco == this.preco &&
          other.descricao == this.descricao);
}

class ProdutosCompanion extends UpdateCompanion<Produto> {
  final Value<int> id;
  final Value<int> confeitariaId;
  final Value<String> nome;
  final Value<double> preco;
  final Value<String?> descricao;
  const ProdutosCompanion({
    this.id = const Value.absent(),
    this.confeitariaId = const Value.absent(),
    this.nome = const Value.absent(),
    this.preco = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  ProdutosCompanion.insert({
    this.id = const Value.absent(),
    required int confeitariaId,
    required String nome,
    required double preco,
    this.descricao = const Value.absent(),
  })  : confeitariaId = Value(confeitariaId),
        nome = Value(nome),
        preco = Value(preco);
  static Insertable<Produto> custom({
    Expression<int>? id,
    Expression<int>? confeitariaId,
    Expression<String>? nome,
    Expression<double>? preco,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (confeitariaId != null) 'confeitaria_id': confeitariaId,
      if (nome != null) 'nome': nome,
      if (preco != null) 'preco': preco,
      if (descricao != null) 'descricao': descricao,
    });
  }

  ProdutosCompanion copyWith(
      {Value<int>? id,
      Value<int>? confeitariaId,
      Value<String>? nome,
      Value<double>? preco,
      Value<String?>? descricao}) {
    return ProdutosCompanion(
      id: id ?? this.id,
      confeitariaId: confeitariaId ?? this.confeitariaId,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (confeitariaId.present) {
      map['confeitaria_id'] = Variable<int>(confeitariaId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (preco.present) {
      map['preco'] = Variable<double>(preco.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutosCompanion(')
          ..write('id: $id, ')
          ..write('confeitariaId: $confeitariaId, ')
          ..write('nome: $nome, ')
          ..write('preco: $preco, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $ProdutoImagensTable extends ProdutoImagens
    with TableInfo<$ProdutoImagensTable, ProdutoImagen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdutoImagensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _produtoIdMeta =
      const VerificationMeta('produtoId');
  @override
  late final GeneratedColumn<int> produtoId = GeneratedColumn<int>(
      'produto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES produtos (id)'));
  static const VerificationMeta _imagemPathMeta =
      const VerificationMeta('imagemPath');
  @override
  late final GeneratedColumn<String> imagemPath = GeneratedColumn<String>(
      'imagem_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, produtoId, imagemPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produto_imagens';
  @override
  VerificationContext validateIntegrity(Insertable<ProdutoImagen> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('produto_id')) {
      context.handle(_produtoIdMeta,
          produtoId.isAcceptableOrUnknown(data['produto_id']!, _produtoIdMeta));
    } else if (isInserting) {
      context.missing(_produtoIdMeta);
    }
    if (data.containsKey('imagem_path')) {
      context.handle(
          _imagemPathMeta,
          imagemPath.isAcceptableOrUnknown(
              data['imagem_path']!, _imagemPathMeta));
    } else if (isInserting) {
      context.missing(_imagemPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdutoImagen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProdutoImagen(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      produtoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produto_id'])!,
      imagemPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagem_path'])!,
    );
  }

  @override
  $ProdutoImagensTable createAlias(String alias) {
    return $ProdutoImagensTable(attachedDatabase, alias);
  }
}

class ProdutoImagen extends DataClass implements Insertable<ProdutoImagen> {
  final int id;
  final int produtoId;
  final String imagemPath;
  const ProdutoImagen(
      {required this.id, required this.produtoId, required this.imagemPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['produto_id'] = Variable<int>(produtoId);
    map['imagem_path'] = Variable<String>(imagemPath);
    return map;
  }

  ProdutoImagensCompanion toCompanion(bool nullToAbsent) {
    return ProdutoImagensCompanion(
      id: Value(id),
      produtoId: Value(produtoId),
      imagemPath: Value(imagemPath),
    );
  }

  factory ProdutoImagen.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProdutoImagen(
      id: serializer.fromJson<int>(json['id']),
      produtoId: serializer.fromJson<int>(json['produtoId']),
      imagemPath: serializer.fromJson<String>(json['imagemPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'produtoId': serializer.toJson<int>(produtoId),
      'imagemPath': serializer.toJson<String>(imagemPath),
    };
  }

  ProdutoImagen copyWith({int? id, int? produtoId, String? imagemPath}) =>
      ProdutoImagen(
        id: id ?? this.id,
        produtoId: produtoId ?? this.produtoId,
        imagemPath: imagemPath ?? this.imagemPath,
      );
  ProdutoImagen copyWithCompanion(ProdutoImagensCompanion data) {
    return ProdutoImagen(
      id: data.id.present ? data.id.value : this.id,
      produtoId: data.produtoId.present ? data.produtoId.value : this.produtoId,
      imagemPath:
          data.imagemPath.present ? data.imagemPath.value : this.imagemPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoImagen(')
          ..write('id: $id, ')
          ..write('produtoId: $produtoId, ')
          ..write('imagemPath: $imagemPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, produtoId, imagemPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdutoImagen &&
          other.id == this.id &&
          other.produtoId == this.produtoId &&
          other.imagemPath == this.imagemPath);
}

class ProdutoImagensCompanion extends UpdateCompanion<ProdutoImagen> {
  final Value<int> id;
  final Value<int> produtoId;
  final Value<String> imagemPath;
  const ProdutoImagensCompanion({
    this.id = const Value.absent(),
    this.produtoId = const Value.absent(),
    this.imagemPath = const Value.absent(),
  });
  ProdutoImagensCompanion.insert({
    this.id = const Value.absent(),
    required int produtoId,
    required String imagemPath,
  })  : produtoId = Value(produtoId),
        imagemPath = Value(imagemPath);
  static Insertable<ProdutoImagen> custom({
    Expression<int>? id,
    Expression<int>? produtoId,
    Expression<String>? imagemPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (produtoId != null) 'produto_id': produtoId,
      if (imagemPath != null) 'imagem_path': imagemPath,
    });
  }

  ProdutoImagensCompanion copyWith(
      {Value<int>? id, Value<int>? produtoId, Value<String>? imagemPath}) {
    return ProdutoImagensCompanion(
      id: id ?? this.id,
      produtoId: produtoId ?? this.produtoId,
      imagemPath: imagemPath ?? this.imagemPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (produtoId.present) {
      map['produto_id'] = Variable<int>(produtoId.value);
    }
    if (imagemPath.present) {
      map['imagem_path'] = Variable<String>(imagemPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdutoImagensCompanion(')
          ..write('id: $id, ')
          ..write('produtoId: $produtoId, ')
          ..write('imagemPath: $imagemPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConfeitariasTable confeitarias = $ConfeitariasTable(this);
  late final $ProdutosTable produtos = $ProdutosTable(this);
  late final $ProdutoImagensTable produtoImagens = $ProdutoImagensTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [confeitarias, produtos, produtoImagens];
}

typedef $$ConfeitariasTableCreateCompanionBuilder = ConfeitariasCompanion
    Function({
  Value<int> id,
  required String nome,
  required double latitude,
  required double longitude,
  required String cep,
  required String rua,
  required String numero,
  required String bairro,
  required String cidade,
  required String estado,
  required String telefone,
  Value<String?> imagemPath,
});
typedef $$ConfeitariasTableUpdateCompanionBuilder = ConfeitariasCompanion
    Function({
  Value<int> id,
  Value<String> nome,
  Value<double> latitude,
  Value<double> longitude,
  Value<String> cep,
  Value<String> rua,
  Value<String> numero,
  Value<String> bairro,
  Value<String> cidade,
  Value<String> estado,
  Value<String> telefone,
  Value<String?> imagemPath,
});

class $$ConfeitariasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConfeitariasTable,
    Confeitaria,
    $$ConfeitariasTableFilterComposer,
    $$ConfeitariasTableOrderingComposer,
    $$ConfeitariasTableCreateCompanionBuilder,
    $$ConfeitariasTableUpdateCompanionBuilder> {
  $$ConfeitariasTableTableManager(_$AppDatabase db, $ConfeitariasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ConfeitariasTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ConfeitariasTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String> cep = const Value.absent(),
            Value<String> rua = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<String> bairro = const Value.absent(),
            Value<String> cidade = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String> telefone = const Value.absent(),
            Value<String?> imagemPath = const Value.absent(),
          }) =>
              ConfeitariasCompanion(
            id: id,
            nome: nome,
            latitude: latitude,
            longitude: longitude,
            cep: cep,
            rua: rua,
            numero: numero,
            bairro: bairro,
            cidade: cidade,
            estado: estado,
            telefone: telefone,
            imagemPath: imagemPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nome,
            required double latitude,
            required double longitude,
            required String cep,
            required String rua,
            required String numero,
            required String bairro,
            required String cidade,
            required String estado,
            required String telefone,
            Value<String?> imagemPath = const Value.absent(),
          }) =>
              ConfeitariasCompanion.insert(
            id: id,
            nome: nome,
            latitude: latitude,
            longitude: longitude,
            cep: cep,
            rua: rua,
            numero: numero,
            bairro: bairro,
            cidade: cidade,
            estado: estado,
            telefone: telefone,
            imagemPath: imagemPath,
          ),
        ));
}

class $$ConfeitariasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConfeitariasTable> {
  $$ConfeitariasTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nome => $state.composableBuilder(
      column: $state.table.nome,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cep => $state.composableBuilder(
      column: $state.table.cep,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get rua => $state.composableBuilder(
      column: $state.table.rua,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get numero => $state.composableBuilder(
      column: $state.table.numero,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get bairro => $state.composableBuilder(
      column: $state.table.bairro,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get cidade => $state.composableBuilder(
      column: $state.table.cidade,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get estado => $state.composableBuilder(
      column: $state.table.estado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get telefone => $state.composableBuilder(
      column: $state.table.telefone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imagemPath => $state.composableBuilder(
      column: $state.table.imagemPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter produtosRefs(
      ComposableFilter Function($$ProdutosTableFilterComposer f) f) {
    final $$ProdutosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.produtos,
        getReferencedColumn: (t) => t.confeitariaId,
        builder: (joinBuilder, parentComposers) =>
            $$ProdutosTableFilterComposer(ComposerState(
                $state.db, $state.db.produtos, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ConfeitariasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConfeitariasTable> {
  $$ConfeitariasTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nome => $state.composableBuilder(
      column: $state.table.nome,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cep => $state.composableBuilder(
      column: $state.table.cep,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get rua => $state.composableBuilder(
      column: $state.table.rua,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get numero => $state.composableBuilder(
      column: $state.table.numero,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get bairro => $state.composableBuilder(
      column: $state.table.bairro,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get cidade => $state.composableBuilder(
      column: $state.table.cidade,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get estado => $state.composableBuilder(
      column: $state.table.estado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get telefone => $state.composableBuilder(
      column: $state.table.telefone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imagemPath => $state.composableBuilder(
      column: $state.table.imagemPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ProdutosTableCreateCompanionBuilder = ProdutosCompanion Function({
  Value<int> id,
  required int confeitariaId,
  required String nome,
  required double preco,
  Value<String?> descricao,
});
typedef $$ProdutosTableUpdateCompanionBuilder = ProdutosCompanion Function({
  Value<int> id,
  Value<int> confeitariaId,
  Value<String> nome,
  Value<double> preco,
  Value<String?> descricao,
});

class $$ProdutosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProdutosTable,
    Produto,
    $$ProdutosTableFilterComposer,
    $$ProdutosTableOrderingComposer,
    $$ProdutosTableCreateCompanionBuilder,
    $$ProdutosTableUpdateCompanionBuilder> {
  $$ProdutosTableTableManager(_$AppDatabase db, $ProdutosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProdutosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProdutosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> confeitariaId = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<double> preco = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              ProdutosCompanion(
            id: id,
            confeitariaId: confeitariaId,
            nome: nome,
            preco: preco,
            descricao: descricao,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int confeitariaId,
            required String nome,
            required double preco,
            Value<String?> descricao = const Value.absent(),
          }) =>
              ProdutosCompanion.insert(
            id: id,
            confeitariaId: confeitariaId,
            nome: nome,
            preco: preco,
            descricao: descricao,
          ),
        ));
}

class $$ProdutosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProdutosTable> {
  $$ProdutosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nome => $state.composableBuilder(
      column: $state.table.nome,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get preco => $state.composableBuilder(
      column: $state.table.preco,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ConfeitariasTableFilterComposer get confeitariaId {
    final $$ConfeitariasTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.confeitariaId,
        referencedTable: $state.db.confeitarias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ConfeitariasTableFilterComposer(ComposerState($state.db,
                $state.db.confeitarias, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter produtoImagensRefs(
      ComposableFilter Function($$ProdutoImagensTableFilterComposer f) f) {
    final $$ProdutoImagensTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.produtoImagens,
        getReferencedColumn: (t) => t.produtoId,
        builder: (joinBuilder, parentComposers) =>
            $$ProdutoImagensTableFilterComposer(ComposerState($state.db,
                $state.db.produtoImagens, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ProdutosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProdutosTable> {
  $$ProdutosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nome => $state.composableBuilder(
      column: $state.table.nome,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get preco => $state.composableBuilder(
      column: $state.table.preco,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ConfeitariasTableOrderingComposer get confeitariaId {
    final $$ConfeitariasTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.confeitariaId,
        referencedTable: $state.db.confeitarias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ConfeitariasTableOrderingComposer(ComposerState($state.db,
                $state.db.confeitarias, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ProdutoImagensTableCreateCompanionBuilder = ProdutoImagensCompanion
    Function({
  Value<int> id,
  required int produtoId,
  required String imagemPath,
});
typedef $$ProdutoImagensTableUpdateCompanionBuilder = ProdutoImagensCompanion
    Function({
  Value<int> id,
  Value<int> produtoId,
  Value<String> imagemPath,
});

class $$ProdutoImagensTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProdutoImagensTable,
    ProdutoImagen,
    $$ProdutoImagensTableFilterComposer,
    $$ProdutoImagensTableOrderingComposer,
    $$ProdutoImagensTableCreateCompanionBuilder,
    $$ProdutoImagensTableUpdateCompanionBuilder> {
  $$ProdutoImagensTableTableManager(
      _$AppDatabase db, $ProdutoImagensTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProdutoImagensTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProdutoImagensTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> produtoId = const Value.absent(),
            Value<String> imagemPath = const Value.absent(),
          }) =>
              ProdutoImagensCompanion(
            id: id,
            produtoId: produtoId,
            imagemPath: imagemPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int produtoId,
            required String imagemPath,
          }) =>
              ProdutoImagensCompanion.insert(
            id: id,
            produtoId: produtoId,
            imagemPath: imagemPath,
          ),
        ));
}

class $$ProdutoImagensTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProdutoImagensTable> {
  $$ProdutoImagensTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imagemPath => $state.composableBuilder(
      column: $state.table.imagemPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ProdutosTableFilterComposer get produtoId {
    final $$ProdutosTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $state.db.produtos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProdutosTableFilterComposer(ComposerState(
                $state.db, $state.db.produtos, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ProdutoImagensTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProdutoImagensTable> {
  $$ProdutoImagensTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imagemPath => $state.composableBuilder(
      column: $state.table.imagemPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ProdutosTableOrderingComposer get produtoId {
    final $$ProdutosTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produtoId,
        referencedTable: $state.db.produtos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProdutosTableOrderingComposer(ComposerState(
                $state.db, $state.db.produtos, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConfeitariasTableTableManager get confeitarias =>
      $$ConfeitariasTableTableManager(_db, _db.confeitarias);
  $$ProdutosTableTableManager get produtos =>
      $$ProdutosTableTableManager(_db, _db.produtos);
  $$ProdutoImagensTableTableManager get produtoImagens =>
      $$ProdutoImagensTableTableManager(_db, _db.produtoImagens);
}
