import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("ProductEntity")
class ProductTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get inUse => boolean().withDefault(const Constant(false))();
  BoolColumn get isReviewed => boolean().withDefault(const Constant(false))();
  IntColumn get quantity => integer()();
  IntColumn get categoryId => integer()();
  DateTimeColumn get useUntil => dateTime().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
