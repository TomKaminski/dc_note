part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsUninitialized extends ProductsState {}

class ProductsError extends ProductsState {}

class ProductsDeleted extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;

  const ProductsLoaded({this.products});

  ProductsLoaded copyWith({List<ProductModel> accounts}) {
    return ProductsLoaded(products: accounts ?? this.products);
  }

  @override
  List<Object> get props => [products];
}
