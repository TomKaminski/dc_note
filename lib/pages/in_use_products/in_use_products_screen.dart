import 'package:DC_Note/pages/category_selector/category_selector_screen.dart';
import 'package:DC_Note/pages/in_use_products/bloc/in_use_products_bloc.dart';
import 'package:DC_Note/pages/in_use_products/in_use_product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class InUseProductsScreen extends StatefulWidget {
  @override
  InUseProductsScreenState createState() {
    return InUseProductsScreenState();
  }
}

class InUseProductsScreenState extends State<InUseProductsScreen> {
  InUseProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InUseProductsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: BottomSearchBarWidget(
            onChanged: (text) => BlocProvider.of<InUseProductsBloc>(context)
                .searchStream
                .add(text),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Używane produkty",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          dynamic result = await Navigator.of(context).pushNamed("/addProduct");
          if (result == true) {
            _bloc.add(LoadInUseProductsEvent(null));
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<InUseProductsBloc, InUseProductsState>(
        bloc: _bloc,
        builder: (
          BuildContext context,
          InUseProductsState state,
        ) {
          if (state is InUseProductsError) {
            return Center(
              child: Text('Błąd pobierania produktów.'),
            );
          }
          if (state is InUseProductsLoaded) {
            // return ListWheelScrollView(
            //   children: state.products
            //       .map((e) => InUseProductListItemWidget(product: e))
            //       .toList(),
            //   itemExtent: 150,
            // );
            return LiquidPullToRefresh(
              backgroundColor: Colors.white,
              springAnimationDurationInMilliseconds: 300,
              onRefresh: () async {
                _bloc.add(LoadInUseProductsEvent(null));
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
                  return InUseProductListItemWidget(
                      product: state.products[index]);
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
        listener: (BuildContext context, InUseProductsState state) {
          if (state is InUseProductsUpdated) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
