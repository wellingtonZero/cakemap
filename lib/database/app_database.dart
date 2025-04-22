import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

class Confeitarias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get cep => text()();
  TextColumn get rua => text()();
  TextColumn get numero => text()();
  TextColumn get bairro => text()();
  TextColumn get cidade => text()();
  TextColumn get estado => text()();
  TextColumn get telefone => text()();
  TextColumn get imagemPath => text().nullable()();
}

class Produtos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get confeitariaId => integer().references(Confeitarias, #id)(); // chave estrangeira
  TextColumn get nome => text()();
  RealColumn get preco => real()();
  TextColumn get descricao => text().nullable()();
  TextColumn get imagemPath => text().nullable()();
}


@DriftDatabase(tables: [Confeitarias, Produtos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  Future<void> deleteConfeitaria(int id) async {
  await (delete(confeitarias)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<Produto>> watchProdutosDaConfeitaria(int confeitariaId) {
  return (select(produtos)..where((tbl) => tbl.confeitariaId.equals(confeitariaId))).watch();
  }
  
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

