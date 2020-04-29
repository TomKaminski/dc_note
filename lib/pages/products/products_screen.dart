import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/pages/products/product_list_item.dart';
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
  final ProductsBloc bloc = ProductsBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(LoadProductsEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Twoje produkty",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          dynamic result = await Navigator.of(context).pushNamed("/addProduct");
          if (result == true) {
            bloc.add(LoadProductsEvent());
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: bloc,
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
              springAnimationDurationInMilliseconds: 300,
              onRefresh: () async {
                bloc.add(LoadProductsEvent());
              },
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (state.products.length == 0) {
                    return ListTile(
                      title: Text(
                        "Brak produktów",
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text("Dotknij + aby dodać nowy produkt."),
                    );
                  }
                  return ProductListItemWidget(product: state.products[index]);
                },
                itemCount:
                    state.products.length == 0 ? 1 : state.products.length,
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (BuildContext context, ProductsState state) {
          if (state is ProductsDeleted) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
