import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/widgets/selector/selector_list.dart';
import 'package:DC_Note/pages/category_selector/bloc/category_selector_bloc.dart';
import 'package:flutter/material.dart';

class CategoryList
    extends SelectorList<CategorySelectorItem, CategorySelectorBloc> {
  @override
  ListTile buildListTile(CategorySelectorItem element) {
    return ListTile(
      title: Text(element.title,
          style: element.parentId == null
              ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              : TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
      leading: element.parentId == null
          ? Icon(Icons.image)
          : Icon(Icons.arrow_right),
    );
  }
}
