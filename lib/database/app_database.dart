import 'package:DC_Note/database/product.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(tables: [
  ProductTable,
], daos: [
  ProductDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'generated/db.sqlite', logStatements: true)
          ..doWhenOpened((e) => e.runCustom('PRAGMA foreign_keys = ON')));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [ProductTable])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(AppDatabase db) : super(db);

  Future<ProductEntity> getSingle(
      Expression<bool, BoolType> Function($ProductTableTable) filter) async {
    return await (select(productTable)..where(filter)).getSingle();
  }

  Future<List<ProductEntity>> getAll() async => select(productTable).get();

  Future insertAll(List<ProductEntity> Products) async {
    db.batch((b) =>
        b.insertAll(productTable, Products, mode: InsertMode.insertOrReplace));
  }

  Future<ProductEntity> getById(int id) async {
    return await (select(productTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<int> deleteById(int id) async {
    return (delete(productTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future removeAll() async {
    return delete(productTable).go();
  }

  Future<int> insert(ProductEntity product) async =>
      into(productTable).insert(product, orReplace: true);
}
