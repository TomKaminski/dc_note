import 'dart:async';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/database/app_database.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  @override
  ProductsState get initialState => ProductsUninitialized();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is LoadProductsEvent) {
      try {
        final productEntities = await Application.database.productDao.getAll();
        final existingCategories =
            productEntities.map((e) => e.categoryId).toSet();
        final categories = Map.fromIterable(
            await Application.database.categoryDao
                .getAllByExpression((tbl) => tbl.id.isIn(existingCategories)),
            key: (e) => e.id,
            value: (e) => e);

        final products = productEntities.map(
            (e) => ProductModel.fromEntity(e, categories[e.categoryId].name));
        yield ProductsLoaded(products: products.toList());
      } catch (error) {
        yield ProductsError();
      }
    } else if (event is DeleteProductEvent) {
      try {
        await Application.database.productDao.deleteById(event.id);
        yield ProductsDeleted();
        final productEntities = await Application.database.productDao.getAll();
        final existingCategories =
            productEntities.map((e) => e.categoryId).toSet();
        final categories = Map.fromIterable(
            await Application.database.categoryDao
                .getAllByExpression((tbl) => tbl.id.isIn(existingCategories)),
            key: (e) => e.id,
            value: (e) => e);

        final products = productEntities.map(
            (e) => ProductModel.fromEntity(e, categories[e.categoryId].name));
        yield ProductsLoaded(products: products.toList());
      } catch (error) {
        yield ProductsError();
      }
    }
  }
}
