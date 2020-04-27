import 'package:DC_Note/database/app_database.dart';

import 'base_app_model.dart';

class ProductModel extends BaseAppModel {
  final int id;
  final bool inUse;
  final double quantity;
  final int categoryId;
  final DateTime useUntil;
  final String name;
  final String categoryName;

  ProductModel(this.id, this.quantity, this.categoryId, this.useUntil,
      this.name, this.inUse, this.categoryName);

  ProductModel.fromEntity(ProductEntity entity, this.categoryName)
      : id = entity.id,
        name = entity.name,
        quantity = entity.quantity,
        categoryId = entity.categoryId,
        inUse = entity.inUse,
        useUntil = entity.useUntil;

  @override
  ProductEntity toEntity() {
    return ProductEntity(
        id: id,
        name: name,
        quantity: quantity,
        categoryId: categoryId,
        useUntil: useUntil,
        inUse: inUse);
  }

  @override
  List<Object> get props => [id, name, quantity, categoryId, useUntil, inUse];
}
