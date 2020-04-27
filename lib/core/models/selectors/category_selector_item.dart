import 'package:DC_Note/core/models/selectors/base_selector_item.dart';
import 'package:flutter/material.dart';

class CategorySelectorItem extends BaseSelectorItem {
  final int parentId;

  CategorySelectorItem(String title, int id, this.parentId) : super(title, id);

  @override
  IconData get icon => null;
}
