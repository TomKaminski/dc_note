part of 'selector_bloc.dart';

abstract class SelectorState<T extends BaseSelectorItem> extends Equatable {
  const SelectorState();
}

class SelectorInitial<T extends BaseSelectorItem> extends SelectorState<T> {
  @override
  List<Object> get props => [];
}

class SelectorErrorState<T extends BaseSelectorItem> extends SelectorState<T> {
  @override
  List<Object> get props => [];
}

class SelectorLoadedState<T extends BaseSelectorItem> extends SelectorState<T> {
  final List<T> items;

  SelectorLoadedState(this.items);

  @override
  List<Object> get props => [items];
}
