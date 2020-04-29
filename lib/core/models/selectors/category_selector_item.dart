import 'package:DC_Note/core/models/selectors/base_selector_item.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:flutter/material.dart';

class CategorySelectorItem extends BaseSelectorItem {
  final int parentId;
  final CategoryKeyEnum category;

  CategorySelectorItem(String title, int id, this.parentId, this.category)
      : super(title, id);

  @override
  AssetImage get icon => AssetImage("assets/images/${category.imageName}");
}
