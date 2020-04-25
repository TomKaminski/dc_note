import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("ProductEntity")
class ProductTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get amountPerItem => real()();
  TextColumn get amountSuffixKey => text()(); //ml/g/kg etc.
  RealColumn get quantity => real()();
  IntColumn get categoryId => integer()();
  DateTimeColumn get useUntil => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
