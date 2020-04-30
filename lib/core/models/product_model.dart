import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:DC_Note/database/app_database.dart';

import 'base_app_model.dart';

class ProductModel extends BaseAppModel {
  final int id;
  final bool inUse;
  final int quantity;
  final DateTime useUntil;
  final String name;
  final String notes;
  final CategorySelectorItem category;

  ProductModel(this.id, this.quantity, this.useUntil, this.name, this.inUse,
      this.category, this.notes);

  ProductModel.fromEntity(ProductEntity entity, CategoryEntity category)
      : id = entity.id,
        name = entity.name,
        notes = entity.notes,
        quantity = entity.quantity,
        category = CategorySelectorItem(
            category.name,
            entity.categoryId,
            category.parentId,
            CategoryKeyEnumExtension.fromString(category.key)),
        inUse = entity.inUse,
        useUntil = entity.useUntil;

  @override
  ProductEntity toEntity() {
    return ProductEntity(
        id: id,
        name: name,
        quantity: quantity,
        notes: notes,
        categoryId: category.id,
        useUntil: useUntil,
        inUse: inUse);
  }

  @override
  List<Object> get props =>
      [id, name, quantity, useUntil, inUse, notes, category];
}
