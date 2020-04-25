import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("CategoryEntity")
class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get key => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ["CONSTRAINT UC_key UNIQUE (key)"];
}
