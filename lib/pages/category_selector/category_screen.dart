import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/pages/category_selector/bloc/category_selector_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_list.dart';

class CategorySelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CategorySelectorBloc()..add(SelectorFetchEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Wybierz kategorię")),
        body: CategoryList(),
      ),
    );
  }
}
