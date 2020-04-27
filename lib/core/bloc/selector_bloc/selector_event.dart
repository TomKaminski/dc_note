part of 'selector_bloc.dart';

abstract class SelectorEvent extends Equatable {
  const SelectorEvent();
}

class SelectorFetchEvent extends SelectorEvent {
  @override
  List<Object> get props => [];
}
