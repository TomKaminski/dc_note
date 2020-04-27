import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/pages/category_selector/bloc/category_selector_bloc.dart';
import 'package:DC_Note/pages/category_selector/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelectorScreen extends StatelessWidget {
  final String title;

  const CategorySelectorScreen({Key key, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CategorySelectorBloc()..add(SelectorFetchEvent()),
      child: Scaffold(appBar: AppBar(title: Text(title)), body: CategoryList()),
    );
  }
}
