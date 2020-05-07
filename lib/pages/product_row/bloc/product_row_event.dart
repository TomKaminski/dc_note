part of 'product_row_bloc.dart';

abstract class ProductRowEvent extends Equatable {
  const ProductRowEvent();
}

class ProductRowEventToggleInUse extends ProductRowEvent {
  final bool inUse;
  ProductRowEventToggleInUse(this.inUse);

  @override
  List<Object> get props => [inUse];
}
