part of 'in_use_products_bloc.dart';

abstract class InUseProductsEvent extends Equatable {
  const InUseProductsEvent();
}

class LoadInUseProductsEvent extends InUseProductsEvent {
  final String searchPhrase;

  LoadInUseProductsEvent(this.searchPhrase);

  @override
  List<Object> get props => [];
}

class InUseProductDetailsEvent extends InUseProductsEvent {
  final int id;

  InUseProductDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFromInUseProductsEvent extends InUseProductsEvent {
  final int id;

  RemoveFromInUseProductsEvent(this.id);

  @override
  List<Object> get props => [id];
}
