import 'dart:async';

import 'package:DC_Note/core/models/selectors/base_selector_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selector_event.dart';
part 'selector_state.dart';

abstract class SelectorBloc<TItem extends BaseSelectorItem>
    extends Bloc<SelectorEvent, SelectorState<TItem>> {
  @override
  SelectorState<TItem> get initialState => SelectorInitial<TItem>();

  @override
  Stream<SelectorState<TItem>> mapEventToState(
    SelectorEvent event,
  ) async* {
    try {
      if (event is SelectorFetchEvent) {
        final items = await fetchItems(event.searchPhrase);
        yield SelectorLoadedState(items);
      }
    } catch (e) {
      yield SelectorErrorState();
    }
  }

  Future<List<TItem>> fetchItems(String searchPhrase);
}
