import 'dart:async';

import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';

class CategorySelectorBloc extends SelectorBloc<CategorySelectorItem> {
  @override
  Future<List<CategorySelectorItem>> fetchItems() async {
    final items = await CategoriesProvider().fetchCategories();
    return items
        .map((e) => CategorySelectorItem(e.name, e.id, e.parentId))
        .toList();
  }
}
