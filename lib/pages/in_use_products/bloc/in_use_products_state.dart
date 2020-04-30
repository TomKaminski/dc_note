part of 'in_use_products_bloc.dart';

abstract class InUseProductsState extends Equatable {
  const InUseProductsState();

  @override
  List<Object> get props => [];
}

class InUseProductsUninitialized extends InUseProductsState {}

class InUseProductsError extends InUseProductsState {}

class InUseProductsUpdated extends InUseProductsState {}

class InUseProductsLoaded extends InUseProductsState {
  final List<ProductModel> products;

  const InUseProductsLoaded({this.products});

  InUseProductsLoaded copyWith({List<ProductModel> accounts}) {
    return InUseProductsLoaded(products: accounts ?? this.products);
  }

  @override
  List<Object> get props => [products];
}
