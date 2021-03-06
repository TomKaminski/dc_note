import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:DC_Note/database/category.dart';
import 'package:DC_Note/database/product.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(tables: [ProductTable, CategoryTable], daos: [ProductDao, CategoryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'generated/db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.addColumn(productTable, productTable.isReviewed);
          }
        },
        beforeOpen: (details) async {
          if (details.versionBefore == 1 && details.versionNow == 2) {
            (update(categoryTable)
                  ..where((t) => t.key.equals("CATEGORY_HAIR_2")))
                .write(
              CategoryTableCompanion(name: Value("odżywki do spłukiwania")),
            );
          }
        },
      );
}

@UseDao(tables: [ProductTable])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(AppDatabase db) : super(db);

  Future<ProductEntity> getSingle(
      Expression<bool, BoolType> Function($ProductTableTable) filter) async {
    return await (select(productTable)..where(filter)).getSingle();
  }

  Future<List<ProductEntity>> getAllByExpression(
      Expression<bool, BoolType> Function($ProductTableTable) filter) async {
    return await (select(productTable)..where(filter)).get();
  }

  Future<List<ProductEntity>> getAll() async => select(productTable).get();

  Future insertAll(List<ProductEntity> products) async {
    db.batch((b) =>
        b.insertAll(productTable, products, mode: InsertMode.insertOrReplace));
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

  Future<bool> updateItem(ProductEntity product) async =>
      update(productTable).replace(product);

  Future<int> toggleInUseProduct(bool inUse, int id) {
    return (update(productTable)..where((t) => t.id.equals(id))).write(
      ProductTableCompanion(inUse: Value(inUse)),
    );
  }
}

@UseDao(tables: [CategoryTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);

  Future<CategoryEntity> getSingle(
      Expression<bool, BoolType> Function($CategoryTableTable) filter) async {
    return await (select(categoryTable)..where(filter)).getSingle();
  }

  Future<List<CategoryEntity>> getAllByExpression(
      Expression<bool, BoolType> Function($CategoryTableTable) filter) async {
    return await ((select(categoryTable)..where(filter))
          ..orderBy([
            (u) => OrderingTerm(expression: u.name, mode: OrderingMode.asc),
          ]))
        .get();
  }

  Future<List<CategoryEntity>> getAll() async => select(categoryTable).get();

  Future insertAll(List<CategoryEntity> categories, InsertMode mode) async {
    db.batch((b) => b.insertAll(categoryTable, categories, mode: mode));
  }

  Future<CategoryEntity> getById(int id) async {
    return await (select(categoryTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<int> deleteById(int id) async {
    return (delete(categoryTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future removeAll() async {
    return delete(categoryTable).go();
  }

  Future<int> insert(CategoryEntity category, InsertMode mode) async =>
      into(categoryTable).insert(category, mode: mode);
}
