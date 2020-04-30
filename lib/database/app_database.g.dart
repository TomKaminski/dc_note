// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ProductEntity extends DataClass implements Insertable<ProductEntity> {
  final int id;
  final String name;
  final bool inUse;
  final int quantity;
  final int categoryId;
  final DateTime useUntil;
  ProductEntity(
      {@required this.id,
      @required this.name,
      @required this.inUse,
      @required this.quantity,
      @required this.categoryId,
      this.useUntil});
  factory ProductEntity.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ProductEntity(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      inUse: boolType.mapFromDatabaseResponse(data['${effectivePrefix}in_use']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      useUntil: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}use_until']),
    );
  }
  factory ProductEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      inUse: serializer.fromJson<bool>(json['inUse']),
      quantity: serializer.fromJson<int>(json['quantity']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      useUntil: serializer.fromJson<DateTime>(json['useUntil']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'inUse': serializer.toJson<bool>(inUse),
      'quantity': serializer.toJson<int>(quantity),
      'categoryId': serializer.toJson<int>(categoryId),
      'useUntil': serializer.toJson<DateTime>(useUntil),
    };
  }

  @override
  ProductTableCompanion createCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      inUse:
          inUse == null && nullToAbsent ? const Value.absent() : Value(inUse),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      useUntil: useUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(useUntil),
    );
  }

  ProductEntity copyWith(
          {int id,
          String name,
          bool inUse,
          int quantity,
          int categoryId,
          DateTime useUntil}) =>
      ProductEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        inUse: inUse ?? this.inUse,
        quantity: quantity ?? this.quantity,
        categoryId: categoryId ?? this.categoryId,
        useUntil: useUntil ?? this.useUntil,
      );
  @override
  String toString() {
    return (StringBuffer('ProductEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('inUse: $inUse, ')
          ..write('quantity: $quantity, ')
          ..write('categoryId: $categoryId, ')
          ..write('useUntil: $useUntil')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              inUse.hashCode,
              $mrjc(quantity.hashCode,
                  $mrjc(categoryId.hashCode, useUntil.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.inUse == this.inUse &&
          other.quantity == this.quantity &&
          other.categoryId == this.categoryId &&
          other.useUntil == this.useUntil);
}

class ProductTableCompanion extends UpdateCompanion<ProductEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> inUse;
  final Value<int> quantity;
  final Value<int> categoryId;
  final Value<DateTime> useUntil;
  const ProductTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.inUse = const Value.absent(),
    this.quantity = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.useUntil = const Value.absent(),
  });
  ProductTableCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required bool inUse,
    @required int quantity,
    @required int categoryId,
    this.useUntil = const Value.absent(),
  })  : name = Value(name),
        inUse = Value(inUse),
        quantity = Value(quantity),
        categoryId = Value(categoryId);
  ProductTableCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<bool> inUse,
      Value<int> quantity,
      Value<int> categoryId,
      Value<DateTime> useUntil}) {
    return ProductTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      inUse: inUse ?? this.inUse,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      useUntil: useUntil ?? this.useUntil,
    );
  }
}

class $ProductTableTable extends ProductTable
    with TableInfo<$ProductTableTable, ProductEntity> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _inUseMeta = const VerificationMeta('inUse');
  GeneratedBoolColumn _inUse;
  @override
  GeneratedBoolColumn get inUse => _inUse ??= _constructInUse();
  GeneratedBoolColumn _constructInUse() {
    return GeneratedBoolColumn(
      'in_use',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedIntColumn _categoryId;
  @override
  GeneratedIntColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn(
      'category_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _useUntilMeta = const VerificationMeta('useUntil');
  GeneratedDateTimeColumn _useUntil;
  @override
  GeneratedDateTimeColumn get useUntil => _useUntil ??= _constructUseUntil();
  GeneratedDateTimeColumn _constructUseUntil() {
    return GeneratedDateTimeColumn(
      'use_until',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, inUse, quantity, categoryId, useUntil];
  @override
  $ProductTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_table';
  @override
  final String actualTableName = 'product_table';
  @override
  VerificationContext validateIntegrity(ProductTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.inUse.present) {
      context.handle(
          _inUseMeta, inUse.isAcceptableValue(d.inUse.value, _inUseMeta));
    } else if (isInserting) {
      context.missing(_inUseMeta);
    }
    if (d.quantity.present) {
      context.handle(_quantityMeta,
          quantity.isAcceptableValue(d.quantity.value, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (d.categoryId.present) {
      context.handle(_categoryIdMeta,
          categoryId.isAcceptableValue(d.categoryId.value, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (d.useUntil.present) {
      context.handle(_useUntilMeta,
          useUntil.isAcceptableValue(d.useUntil.value, _useUntilMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductEntity map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductEntity.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ProductTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.inUse.present) {
      map['in_use'] = Variable<bool, BoolType>(d.inUse.value);
    }
    if (d.quantity.present) {
      map['quantity'] = Variable<int, IntType>(d.quantity.value);
    }
    if (d.categoryId.present) {
      map['category_id'] = Variable<int, IntType>(d.categoryId.value);
    }
    if (d.useUntil.present) {
      map['use_until'] = Variable<DateTime, DateTimeType>(d.useUntil.value);
    }
    return map;
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(_db, alias);
  }
}

class CategoryEntity extends DataClass implements Insertable<CategoryEntity> {
  final int id;
  final int parentId;
  final String name;
  final String key;
  CategoryEntity(
      {@required this.id,
      this.parentId,
      @required this.name,
      @required this.key});
  factory CategoryEntity.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return CategoryEntity(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      parentId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      key: stringType.mapFromDatabaseResponse(data['${effectivePrefix}key']),
    );
  }
  factory CategoryEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CategoryEntity(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      key: serializer.fromJson<String>(json['key']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int>(parentId),
      'name': serializer.toJson<String>(name),
      'key': serializer.toJson<String>(key),
    };
  }

  @override
  CategoryTableCompanion createCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
    );
  }

  CategoryEntity copyWith({int id, int parentId, String name, String key}) =>
      CategoryEntity(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        name: name ?? this.name,
        key: key ?? this.key,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryEntity(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(parentId.hashCode, $mrjc(name.hashCode, key.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CategoryEntity &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.key == this.key);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryEntity> {
  final Value<int> id;
  final Value<int> parentId;
  final Value<String> name;
  final Value<String> key;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.key = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    @required String name,
    @required String key,
  })  : name = Value(name),
        key = Value(key);
  CategoryTableCompanion copyWith(
      {Value<int> id,
      Value<int> parentId,
      Value<String> name,
      Value<String> key}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      key: key ?? this.key,
    );
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryEntity> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoryTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  GeneratedIntColumn _parentId;
  @override
  GeneratedIntColumn get parentId => _parentId ??= _constructParentId();
  GeneratedIntColumn _constructParentId() {
    return GeneratedIntColumn(
      'parent_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _keyMeta = const VerificationMeta('key');
  GeneratedTextColumn _key;
  @override
  GeneratedTextColumn get key => _key ??= _constructKey();
  GeneratedTextColumn _constructKey() {
    return GeneratedTextColumn(
      'key',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, parentId, name, key];
  @override
  $CategoryTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'category_table';
  @override
  final String actualTableName = 'category_table';
  @override
  VerificationContext validateIntegrity(CategoryTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.parentId.present) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableValue(d.parentId.value, _parentIdMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.key.present) {
      context.handle(_keyMeta, key.isAcceptableValue(d.key.value, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntity map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CategoryEntity.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoryTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.parentId.present) {
      map['parent_id'] = Variable<int, IntType>(d.parentId.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.key.present) {
      map['key'] = Variable<String, StringType>(d.key.value);
    }
    return map;
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ProductTableTable _productTable;
  $ProductTableTable get productTable =>
      _productTable ??= $ProductTableTable(this);
  $CategoryTableTable _categoryTable;
  $CategoryTableTable get categoryTable =>
      _categoryTable ??= $CategoryTableTable(this);
  ProductDao _productDao;
  ProductDao get productDao => _productDao ??= ProductDao(this as AppDatabase);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [productTable, categoryTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ProductDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductTableTable get productTable => db.productTable;
}
mixin _$CategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoryTableTable get categoryTable => db.categoryTable;
}
