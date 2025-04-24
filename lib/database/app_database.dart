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
  IntColumn get confeitariaId => integer().references(Confeitarias, #id)();
  TextColumn get nome => text()();
  RealColumn get preco => real()();
  TextColumn get descricao => text().nullable()();
}

class ProdutoImagens extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get produtoId => integer().references(Produtos, #id)();
  TextColumn get imagemPath => text()();
}

@DriftDatabase(tables: [Confeitarias, Produtos, ProdutoImagens])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          await m.createTable(produtoImagens);
        }
      },
    );
  }

  Future<void> deleteConfeitaria(int id) async {
    await transaction(() async {
      await (delete(produtos)..where((tbl) => tbl.confeitariaId.equals(id))).go();
      await (delete(confeitarias)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Stream<List<Produto>> watchProdutosDaConfeitaria(int confeitariaId) {
    return (select(produtos)..where((tbl) => tbl.confeitariaId.equals(confeitariaId))).watch();
  }

  Future<List<String>> getImagensProduto(int produtoId) async {
    final imagens = await (select(produtoImagens)
      ..where((tbl) => tbl.produtoId.equals(produtoId)))
      .get();
    return imagens.map((img) => img.imagemPath).toList();
  }

  Stream<List<String>> watchImagensProduto(int produtoId) {
    return (select(produtoImagens)
      ..where((tbl) => tbl.produtoId.equals(produtoId)))
      .watch()
      .map((imagens) => imagens.map((img) => img.imagemPath).toList());
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}