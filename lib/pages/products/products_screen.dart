import 'package:DC_Note/core/statics/adds.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/category_selector/category_selector_screen.dart';
import 'package:DC_Note/pages/product_row/base_product_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'bloc/products_bloc.dart';

class ProductsScreen extends StatefulWidget {
  @override
  ProductsScreenState createState() {
    return ProductsScreenState();
  }
}

class ProductsScreenState extends State<ProductsScreen> {
  ProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ProductsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: BottomSearchBarWidget(
            onChanged: (text) =>
                BlocProvider.of<ProductsBloc>(context).searchStream.add(text),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Wszystkie produkty",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          dynamic result = await Navigator.of(context).pushNamed("/addProduct");
          if (result == true) {
            _bloc.add(LoadProductsEvent(null));
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: _bloc,
        builder: (
          BuildContext context,
          ProductsState state,
        ) {
          if (state is ProductsError) {
            return Center(
              child: Text('Błąd pobierania produktów.'),
            );
          }
          if (state is ProductsLoaded) {
            return LiquidPullToRefresh(
              backgroundColor: Colors.white,
              color: AppColors.primary,
              springAnimationDurationInMilliseconds: 300,
              onRefresh: () async {
                _bloc.add(LoadProductsEvent(null));
              },
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    final category = state.categories[index];
                    return ExpansionTile(
                      title: Row(
                        children: [
                          ImageIcon(
                            category.entry.icon,
                            size: 30,
                            color: AppColors.secondary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${category.entry.title}${category.children.length > 0 ? " ( ${category.productsCount} )" : ""}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      children: category.children.length != 0 ||
                              category.productsChildren.length != 0
                          ? <Widget>[] +
                              category.productsChildren
                                  .map((e) => BaseProductRowWidget(
                                      product: e, hideCategory: true))
                                  .toList() +
                              category.children
                                  .map((innerCategory) => ExpansionTile(
                                      title: Text(
                                        '${innerCategory.entry.title} ( ${innerCategory.children.length} )',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      children: innerCategory.children
                                          .map(
                                              (product) => BaseProductRowWidget(
                                                    product: product,
                                                    hideCategory: true,
                                                  ))
                                          .toList()))
                                  .toList()
                          : [
                              ListTile(
                                title: Text(
                                  "Brak produktów dla tej kategorii",
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle:
                                    Text("Dotknij + aby dodać nowy produkt."),
                              )
                            ],
                    );
                  },
                  itemCount: state.categories.length),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (BuildContext context, ProductsState state) {},
      ),
    );
  }
}
