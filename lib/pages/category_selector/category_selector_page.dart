import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/pages/category_selector/category_selector_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/category_selector_bloc.dart';

class CategorySelectorPage extends StatelessWidget {
  final String title;

  const CategorySelectorPage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategorySelectorBloc()..add(SelectorFetchEvent(null)),
      child: CategorySelectorScreen(title: title),
    );
  }
}
