import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:DC_Note/database/app_database.dart';

import 'base_app_model.dart';

class CategoryEntry {
  final CategorySelectorItem entry;
  final List<InnerCategoryEntry> children;
  final List<ProductModel> productsChildren;

  final int productsCount;

  CategoryEntry(
      this.entry, this.children, this.productsCount, this.productsChildren);
}

class InnerCategoryEntry {
  final CategorySelectorItem entry;
  final List<ProductModel> children;

  InnerCategoryEntry(this.entry, this.children);
}

class ProductModel extends BaseAppModel {
  final int id;
  final bool inUse;
  final bool reviewed;
  final int quantity;
  final DateTime useUntil;
  final String name;
  final String notes;
  final CategorySelectorItem category;

  ProductModel(this.id, this.quantity, this.useUntil, this.name, this.inUse,
      this.category, this.notes, this.reviewed);

  ProductModel.fromEntity(ProductEntity entity, CategoryEntity category)
      : id = entity.id,
        name = entity.name,
        notes = entity.notes,
        quantity = entity.quantity,
        reviewed = entity.isReviewed,
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
        isReviewed: reviewed,
        notes: notes,
        categoryId: category.id,
        useUntil: useUntil,
        inUse: inUse);
  }

  @override
  List<Object> get props =>
      [id, name, quantity, useUntil, inUse, notes, category];
}
