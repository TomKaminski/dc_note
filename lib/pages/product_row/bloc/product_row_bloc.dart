import 'dart:async';

import 'package:DC_Note/core/bloc/boolean_state.dart';
import 'package:DC_Note/core/models/app_error.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_row_event.dart';
part 'product_row_state.dart';

class ProductRowBloc extends Bloc<ProductRowEvent, ProductRowState> {
  final int productId;
  final bool initialIsInUse;

  ProductRowBloc(this.productId, this.initialIsInUse);

  @override
  ProductRowState get initialState =>
      ProductRowState.successful(initialIsInUse);

  @override
  Stream<ProductRowState> mapEventToState(
    ProductRowEvent event,
  ) async* {
    try {
      if (event is ProductRowEventToggleInUse) {
        yield ProductRowState.processing(state.data);
        await Future.delayed(const Duration(milliseconds: 500));
        await Application.database.productDao
            .toggleInUseProduct(event.inUse, productId);
        yield ProductRowState.successful(event.inUse);
      }
    } catch (e) {
      yield ProductRowState.successful(state.data);
    }
  }
}
