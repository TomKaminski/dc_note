import 'package:DC_Note/pages/in_use_products/bloc/in_use_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'in_use_products_screen.dart';

class InUseProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InUseProductsBloc()..add(LoadInUseProductsEvent(null)),
      child: InUseProductsScreen(),
    );
  }
}
