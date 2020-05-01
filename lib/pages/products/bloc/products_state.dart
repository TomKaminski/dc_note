part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsUninitialized extends ProductsState {}

class ProductsError extends ProductsState {}

class ProductsUpdated extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<CategoryEntry> categories;

  const ProductsLoaded({this.categories});

  ProductsLoaded copyWith({List<CategoryEntry> categories}) {
    return ProductsLoaded(categories: categories ?? this.categories);
  }

  @override
  List<Object> get props => [categories];
}
