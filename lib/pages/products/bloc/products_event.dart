part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class LoadProductsEvent extends ProductsEvent {
  final String searchPhrase;

  LoadProductsEvent(this.searchPhrase);
  @override
  List<Object> get props => [];
}

class DeleteProductEvent extends ProductsEvent {
  final int id;

  DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ToggleInUseProductsEvent extends ProductsEvent {
  final int id;
  final bool inUse;

  ToggleInUseProductsEvent(this.id, this.inUse);

  @override
  List<Object> get props => [id];
}

class ProductDetailsEvent extends ProductsEvent {
  final int id;

  ProductDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
