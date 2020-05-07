import 'package:DC_Note/pages/products/bloc/products_bloc.dart';
import 'package:DC_Note/pages/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(false)..add(LoadProductsEvent(null)),
      child: ProductsScreen(),
    );
  }
}
