import 'dart:async';

import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:rxdart/rxdart.dart';

class CategorySelectorBloc extends SelectorBloc<CategorySelectorItem> {
  final searchStream = BehaviorSubject<String>();

  CategorySelectorBloc() {
    searchStream
        .distinct()
        .debounceTime(Duration(milliseconds: 250))
        .listen((event) {
      add(SelectorFetchEvent(event));
    });
  }

  @override
  Future<List<CategorySelectorItem>> fetchItems(String searchPhrase) async {
    final items = await CategoriesProvider().fetchCategories(searchPhrase);
    return items
        .map((e) => CategorySelectorItem(e.name, e.id, e.parentId,
            CategoryKeyEnumExtension.fromString(e.key)))
        .toList();
  }

  @override
  Future<void> close() {
    searchStream.close();
    return super.close();
  }
}
