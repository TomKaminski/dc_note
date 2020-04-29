import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/core/statics/colors.dart';
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
      create: (ctx) => CategorySelectorBloc()..add(SelectorFetchEvent(null)),
      child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: BottomSearchBarWidget(),
            ),
            centerTitle: true,
            title: Text(
              "Wybierz kategorię",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          body: CategoryList()),
    );
  }
}

class BottomSearchBarWidget extends StatelessWidget {
  const BottomSearchBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.main,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
        child: TextField(
          onChanged: (text) => BlocProvider.of<CategorySelectorBloc>(context)
              .searchStream
              .add(text),
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Wyszukaj",
              fillColor: Colors.white54),
        ),
      ),
    );
  }
}
