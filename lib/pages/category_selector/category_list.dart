import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:DC_Note/core/statics/colors.dart';
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
              ? TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.main)
              : TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black)),
      leading: element.parentId == null
          ? ImageIcon(
              AssetImage("assets/images/${element.category.imageName}"),
              size: 34,
              color: AppColors.main,
            )
          : null,
    );
  }
}
