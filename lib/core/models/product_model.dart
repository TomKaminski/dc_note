import 'package:DC_Note/database/app_database.dart';

import 'base_app_model.dart';

class ProductModel extends BaseAppModel {
  final int id;
  final double amountPerItem;
  final String amountSuffixKey;
  final double quantity;
  final int categoryId;
  final DateTime useUntil;
  final String name;

  ProductModel(this.id, this.amountPerItem, this.amountSuffixKey, this.quantity,
      this.categoryId, this.useUntil, this.name);

  ProductModel.fromEntity(ProductEntity entity)
      : id = entity.id,
        name = entity.name,
        amountPerItem = entity.amountPerItem,
        amountSuffixKey = entity.amountSuffixKey,
        quantity = entity.quantity,
        categoryId = entity.categoryId,
        useUntil = entity.useUntil;

  @override
  ProductEntity toEntity() {
    return ProductEntity(
        amountPerItem: amountPerItem,
        id: id,
        name: name,
        amountSuffixKey: amountSuffixKey,
        quantity: quantity,
        categoryId: categoryId,
        useUntil: useUntil);
  }

  @override
  List<Object> get props => [
        id,
        amountSuffixKey,
        name,
        quantity,
        categoryId,
        useUntil,
        amountPerItem
      ];
}
