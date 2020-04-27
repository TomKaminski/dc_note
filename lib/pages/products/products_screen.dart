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
    final mainColor = Color.fromARGB(255, 137, 181, 240);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[mainColor, Colors.white],
                stops: [0.3, 1]),
          ),
        ),
        centerTitle: false,
        title: Text(
          "Twoje produkty",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await Navigator.of(context).push(
          //     MaterialPageRoute(builder: (ctx) => CategorySelectorScreen()));

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
