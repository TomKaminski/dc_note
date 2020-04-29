part of 'selector_bloc.dart';

abstract class SelectorEvent extends Equatable {
  const SelectorEvent();
}

class SelectorFetchEvent extends SelectorEvent {
  final String searchPhrase;

  SelectorFetchEvent(this.searchPhrase);

  @override
  List<Object> get props => [];
}
