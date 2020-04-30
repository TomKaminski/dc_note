import 'dart:async';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'in_use_products_event.dart';
part 'in_use_products_state.dart';

class InUseProductsBloc extends Bloc<InUseProductsEvent, InUseProductsState> {
  final searchStream = BehaviorSubject<String>();

  @override
  Future<void> close() {
    searchStream.close();
    return super.close();
  }

  InUseProductsBloc() {
    searchStream
        .distinct()
        .debounceTime(Duration(milliseconds: 400))
        .listen((event) {
      add(LoadInUseProductsEvent(event));
    });
  }

  @override
  InUseProductsState get initialState => InUseProductsUninitialized();

  @override
  Stream<InUseProductsState> mapEventToState(
    InUseProductsEvent event,
  ) async* {
    if (event is LoadInUseProductsEvent) {
      try {
        final products =
            (await fetchProducts(event.searchPhrase ?? searchStream.value))
                .toList();
        yield InUseProductsLoaded(products: products.toList());
      } catch (error) {
        yield InUseProductsError();
      }
    } else if (event is RemoveFromInUseProductsEvent) {
      try {
        await Application.database.productDao
            .toggleInUseProduct(false, event.id);
        yield InUseProductsUpdated();
        final products = (await fetchProducts(searchStream.value)).toList();
        yield InUseProductsLoaded(products: products.toList());
      } catch (error) {
        yield InUseProductsError();
      }
    }
  }

  Future<Iterable<ProductModel>> fetchProducts(String searchPhrase) async {
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
}
