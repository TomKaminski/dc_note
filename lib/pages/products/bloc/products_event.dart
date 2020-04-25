part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class LoadProductsEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class DeleteProductEvent extends ProductsEvent {
  final int id;

  DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ProductDetailsEvent extends ProductsEvent {
  final int id;

  ProductDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
