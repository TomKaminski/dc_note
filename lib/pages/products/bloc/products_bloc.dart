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
  final bool onlyFavourites;

  final searchStream = BehaviorSubject<String>();

  @override
  Future<void> close() {
    searchStream.close();
    return super.close();
  }

  ProductsBloc(this.onlyFavourites) {
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
        if (onlyFavourites) {
          final products = (await fetchInUseProducts(
                  event.searchPhrase ?? searchStream.value))
              .toList();
          yield InUseProductsLoaded(products: products);
        } else {
          final products = (await fetchGroupedProducts(
                  event.searchPhrase ?? searchStream.value))
              .toList();
          yield ProductsLoaded(categories: products);
        }
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

  Future<Iterable<ProductModel>> fetchInUseProducts(String searchPhrase) async {
    List<ProductEntity> entities;
    if (searchPhrase?.isNotEmpty == true) {
      entities = await Application.database.productDao.getAllByExpression(
          (tbl) => tbl.name.like("%$searchPhrase%") & tbl.inUse.equals(true));
    } else {
      entities = await Application.database.productDao
          .getAllByExpression((tbl) => tbl.inUse.equals(true));
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
    Map<int, CategoryEntity> categories = Map.fromIterable(
        await Application.database.categoryDao
            .getAllByExpression((tbl) => tbl.id.isIn(existingCategories)),
        key: (e) => e.id,
        value: (e) => e);

    final products = entities
        .map((e) => ProductModel.fromEntity(e, categories[e.categoryId]));

    List<CategoryEntry> result = [];
    mainCategories.forEach((category) {
      var innerProductsCount = 0;
      final innerCategoriesWithProducts = categories.entries
          .where((element) => element.value.parentId == category.id)
          .map((e) {
            final prods = products
                .where((element) => element.category.id == e.value.id)
                .toList();
            innerProductsCount += prods.length;
            return InnerCategoryEntry(
              CategorySelectorItem(e.value.name, e.value.id, e.value.parentId,
                  CategoryKeyEnumExtension.fromString(category.key)),
              prods,
            );
          })
          .where((element) => element.children.isNotEmpty)
          .toList();
      final productsForMainCategory = products
          .where((element) => element.category.id == category.id)
          .toList();
      result.add(
        CategoryEntry(
            CategorySelectorItem(category.name, category.id, category.parentId,
                CategoryKeyEnumExtension.fromString(category.key)),
            innerCategoriesWithProducts,
            productsForMainCategory.length + innerProductsCount,
            productsForMainCategory),
      );
    });
    return result;
  }
}
