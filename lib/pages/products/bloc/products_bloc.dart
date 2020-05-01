import 'dart:async';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/core/statics/categories_provider.dart';
import 'package:DC_Note/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final searchStream = BehaviorSubject<String>();

  @override
  Future<void> close() {
    searchStream.close();
    return super.close();
  }

  ProductsBloc() {
    searchStream
        .distinct()
        .debounceTime(Duration(milliseconds: 400))
        .listen((event) {
      add(LoadProductsEvent(event));
    });
  }

  @override
  ProductsState get initialState => ProductsUninitialized();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is LoadProductsEvent) {
      try {
        final products = (await fetchGroupedProducts(
                event.searchPhrase ?? searchStream.value))
            .toList();
        yield ProductsLoaded(categories: products);
      } catch (error) {
        yield ProductsError();
      }
    } else if (event is DeleteProductEvent) {
      try {
        await Application.database.productDao.deleteById(event.id);
        yield ProductsUpdated();
        final products =
            (await fetchGroupedProducts(searchStream.value)).toList();
        yield ProductsLoaded(categories: products.toList());
      } catch (error) {
        yield ProductsError();
      }
    } else if (event is ToggleInUseProductsEvent) {
      try {
        await Application.database.productDao
            .toggleInUseProduct(event.inUse, event.id);
        yield ProductsUpdated();
        final products =
            (await fetchGroupedProducts(searchStream.value)).toList();
        yield ProductsLoaded(categories: products.toList());
      } catch (error) {
        yield ProductsError();
      }
    }
  }

  Future<Iterable<ProductModel>> fetchProducts(String searchPhrase) async {
    List<ProductEntity> entities;
    if (searchPhrase?.isNotEmpty == true) {
      entities = await Application.database.productDao
          .getAllByExpression((tbl) => tbl.name.like("%$searchPhrase%"));
    } else {
      entities = await Application.database.productDao.getAll();
    }

    final existingCategories = entities.map((e) => e.categoryId).toSet();
    final categories = Map.fromIterable(
        await Application.database.categoryDao
            .getAllByExpression((tbl) => tbl.id.isIn(existingCategories)),
        key: (e) => e.id,
        value: (e) => e);

    final products = entities
        .map((e) => ProductModel.fromEntity(e, categories[e.categoryId]));
    return products;
  }

  Future<Iterable<CategoryEntry>> fetchGroupedProducts(
      String searchPhrase) async {
    final mainCategories = await Application.database.categoryDao
        .getAllByExpression((tbl) => isNull(tbl.parentId));

    List<ProductEntity> entities;
    if (searchPhrase?.isNotEmpty == true) {
      entities = await Application.database.productDao
          .getAllByExpression((tbl) => tbl.name.like("%$searchPhrase%"));
    } else {
      entities = await Application.database.productDao.getAll();
    }

    final existingCategories = entities.map((e) => e.categoryId).toSet();
    final categories = Map.fromIterable(
        await Application.database.categoryDao
            .getAllByExpression((tbl) => tbl.id.isIn(existingCategories)),
        key: (e) => e.id,
        value: (e) => e);

    final products = entities
        .map((e) => ProductModel.fromEntity(e, categories[e.categoryId]));

    List<CategoryEntry> result = [];
    mainCategories.forEach((category) {
      result.add(CategoryEntry(
          CategorySelectorItem(category.name, category.id, category.parentId,
              CategoryKeyEnumExtension.fromString(category.key)),
          products
              .where((element) =>
                  element.category.id == category.id ||
                  element.category.parentId == category.id)
              .toList()));
    });
    return result;
  }
}
