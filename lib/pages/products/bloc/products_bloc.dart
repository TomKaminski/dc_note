import 'dart:async';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/application.dart';
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
        final products = (await Application.database.productDao.getAll())
            .map((e) => ProductModel.fromEntity(e));
        yield ProductsLoaded(products: products.toList());
      } catch (error) {
        yield ProductsError();
      }
    } else if (event is DeleteProductEvent) {
      try {
        await Application.database.productDao.deleteById(event.id);
        yield ProductsDeleted();
        final products = (await Application.database.productDao.getAll())
            .map((e) => ProductModel.fromEntity(e));
        yield ProductsLoaded(products: products);
      } catch (error) {
        yield ProductsError();
      }
    }
  }
}
