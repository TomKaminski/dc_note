import 'package:DC_Note/core/bloc/selector_bloc/selector_bloc.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/category_selector/bloc/category_selector_bloc.dart';
import 'package:DC_Note/pages/category_selector/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CategorySelectorScreen extends StatefulWidget {
  final String title;

  const CategorySelectorScreen({Key key, @required this.title})
      : super(key: key);

  @override
  _CategorySelectorScreenState createState() => _CategorySelectorScreenState();
}

class _CategorySelectorScreenState extends State<CategorySelectorScreen> {
  CategorySelectorBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CategorySelectorBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: BottomSearchBarWidget(
              onChanged: (text) => _bloc.searchStream.add(text),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Wybierz kategorię",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: CategoryList());
  }
}

class BottomSearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;

  const BottomSearchBarWidget({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(34, 0, 34, 8),
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          style: NeumorphicStyle(color: AppColors.buttonsGrey, depth: -10),
          child: TextField(
            cursorColor: AppColors.secondary,
            onChanged: (text) => onChanged(text),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                hintStyle: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w600),
                hintText: "Wyszukaj"),
          ),
        ),
      ),
    );
  }
}
