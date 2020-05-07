import 'package:DC_Note/pages/products/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'in_use_products_screen.dart';

class InUseProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(true)..add(LoadProductsEvent(null)),
      child: InUseProductsScreen(),
    );
  }
}
