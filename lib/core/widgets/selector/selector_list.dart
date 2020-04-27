import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/core/models/selectors/base_selector_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectorList<TItem extends BaseSelectorItem,
    TBloc extends SelectorBloc<TItem>> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: BlocProvider.of<TBloc>(context),
      builder: (BuildContext context, SelectorState state) {
        if (state is SelectorInitial) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SelectorLoadedState<TItem>) {
          return ListView.builder(
            itemBuilder: (ctx, i) {
              final element = state.items[i];
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(element);
                },
                child: buildListTile(element),
              );
            },
            itemCount: state.items.length,
          );
        }

        return Center(
          child: Text("Błąd ładowania kategorii"),
        );
      },
      listener: (BuildContext context, SelectorState state) {},
    );
  }

  ListTile buildListTile(TItem element) {
    return ListTile(
      title: Text(element.title,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
      leading: Icon(Icons.arrow_right),
    );
  }
}
