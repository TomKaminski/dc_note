// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ProductEntity extends DataClass implements Insertable<ProductEntity> {
  final int id;
  final String name;
  final double amountPerItem;
  final String amountSuffixKey;
  final double quantity;
  final int categoryId;
  final DateTime useUntil;
  ProductEntity(
      {@required this.id,
      @required this.name,
      @required this.amountPerItem,
      @required this.amountSuffixKey,
      @required this.quantity,
      @required this.categoryId,
      @required this.useUntil});
  factory ProductEntity.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ProductEntity(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      amountPerItem: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_per_item']),
      amountSuffixKey: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_suffix_key']),
      quantity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
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
      amountPerItem: serializer.fromJson<double>(json['amountPerItem']),
      amountSuffixKey: serializer.fromJson<String>(json['amountSuffixKey']),
      quantity: serializer.fromJson<double>(json['quantity']),
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
      'amountPerItem': serializer.toJson<double>(amountPerItem),
      'amountSuffixKey': serializer.toJson<String>(amountSuffixKey),
      'quantity': serializer.toJson<double>(quantity),
      'categoryId': serializer.toJson<int>(categoryId),
      'useUntil': serializer.toJson<DateTime>(useUntil),
    };
  }

  @override
  ProductTableCompanion createCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      amountPerItem: amountPerItem == null && nullToAbsent
          ? const Value.absent()
          : Value(amountPerItem),
      amountSuffixKey: amountSuffixKey == null && nullToAbsent
          ? const Value.absent()
          : Value(amountSuffixKey),
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
          double amountPerItem,
          String amountSuffixKey,
          double quantity,
          int categoryId,
          DateTime useUntil}) =>
      ProductEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        amountPerItem: amountPerItem ?? this.amountPerItem,
        amountSuffixKey: amountSuffixKey ?? this.amountSuffixKey,
        quantity: quantity ?? this.quantity,
        categoryId: categoryId ?? this.categoryId,
        useUntil: useUntil ?? this.useUntil,
      );
  @override
  String toString() {
    return (StringBuffer('ProductEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amountPerItem: $amountPerItem, ')
          ..write('amountSuffixKey: $amountSuffixKey, ')
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
              amountPerItem.hashCode,
              $mrjc(
                  amountSuffixKey.hashCode,
                  $mrjc(quantity.hashCode,
                      $mrjc(categoryId.hashCode, useUntil.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.amountPerItem == this.amountPerItem &&
          other.amountSuffixKey == this.amountSuffixKey &&
          other.quantity == this.quantity &&
          other.categoryId == this.categoryId &&
          other.useUntil == this.useUntil);
}

class ProductTableCompanion extends UpdateCompanion<ProductEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> amountPerItem;
  final Value<String> amountSuffixKey;
  final Value<double> quantity;
  final Value<int> categoryId;
  final Value<DateTime> useUntil;
  const ProductTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amountPerItem = const Value.absent(),
    this.amountSuffixKey = const Value.absent(),
    this.quantity = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.useUntil = const Value.absent(),
  });
  ProductTableCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required double amountPerItem,
    @required String amountSuffixKey,
    @required double quantity,
    @required int categoryId,
    @required DateTime useUntil,
  })  : name = Value(name),
        amountPerItem = Value(amountPerItem),
        amountSuffixKey = Value(amountSuffixKey),
        quantity = Value(quantity),
        categoryId = Value(categoryId),
        useUntil = Value(useUntil);
  ProductTableCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<double> amountPerItem,
      Value<String> amountSuffixKey,
      Value<double> quantity,
      Value<int> categoryId,
      Value<DateTime> useUntil}) {
    return ProductTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amountPerItem: amountPerItem ?? this.amountPerItem,
      amountSuffixKey: amountSuffixKey ?? this.amountSuffixKey,
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

  final VerificationMeta _amountPerItemMeta =
      const VerificationMeta('amountPerItem');
  GeneratedRealColumn _amountPerItem;
  @override
  GeneratedRealColumn get amountPerItem =>
      _amountPerItem ??= _constructAmountPerItem();
  GeneratedRealColumn _constructAmountPerItem() {
    return GeneratedRealColumn(
      'amount_per_item',
      $tableName,
      false,
    );
  }

  final VerificationMeta _amountSuffixKeyMeta =
      const VerificationMeta('amountSuffixKey');
  GeneratedTextColumn _amountSuffixKey;
  @override
  GeneratedTextColumn get amountSuffixKey =>
      _amountSuffixKey ??= _constructAmountSuffixKey();
  GeneratedTextColumn _constructAmountSuffixKey() {
    return GeneratedTextColumn(
      'amount_suffix_key',
      $tableName,
      false,
    );
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedRealColumn _quantity;
  @override
  GeneratedRealColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedRealColumn _constructQuantity() {
    return GeneratedRealColumn(
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
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        amountPerItem,
        amountSuffixKey,
        quantity,
        categoryId,
        useUntil
      ];
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
    if (d.amountPerItem.present) {
      context.handle(
          _amountPerItemMeta,
          amountPerItem.isAcceptableValue(
              d.amountPerItem.value, _amountPerItemMeta));
    } else if (isInserting) {
      context.missing(_amountPerItemMeta);
    }
    if (d.amountSuffixKey.present) {
      context.handle(
          _amountSuffixKeyMeta,
          amountSuffixKey.isAcceptableValue(
              d.amountSuffixKey.value, _amountSuffixKeyMeta));
    } else if (isInserting) {
      context.missing(_amountSuffixKeyMeta);
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
    } else if (isInserting) {
      context.missing(_useUntilMeta);
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
    if (d.amountPerItem.present) {
      map['amount_per_item'] =
          Variable<double, RealType>(d.amountPerItem.value);
    }
    if (d.amountSuffixKey.present) {
      map['amount_suffix_key'] =
          Variable<String, StringType>(d.amountSuffixKey.value);
    }
    if (d.quantity.present) {
      map['quantity'] = Variable<double, RealType>(d.quantity.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ProductTableTable _productTable;
  $ProductTableTable get productTable =>
      _productTable ??= $ProductTableTable(this);
  ProductDao _productDao;
  ProductDao get productDao => _productDao ??= ProductDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [productTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ProductDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductTableTable get productTable => db.productTable;
}
