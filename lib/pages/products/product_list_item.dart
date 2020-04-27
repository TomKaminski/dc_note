import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/widgets/modal/modal_action_widget.dart';
import 'package:DC_Note/core/widgets/modal/modal_with_actions_widget.dart';
import 'package:DC_Note/pages/products/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductListItemWidget({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      onLongPress: () {
        final productBloc = BlocProvider.of<ProductsBloc>(context);
        showDialog(
          context: context,
          builder: (context) {
            return ModalActionWidget(
              title: "Wybierz akcję",
              description: null,
              actions: [
                ModalActionItem(
                    name: "Usuń konto",
                    textColor: Colors.red,
                    onPressed: () {
                      productBloc.add(DeleteProductEvent(product.id));
                    }),
                ModalActionItem(
                    name: "Przejdź do szczegółów",
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                ModalActionItem(
                    name: "Przypnij do dashboardu",
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          },
        );
      },
      title: Text("${product.quantity}x ${product.name}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(
            "Ważne do ${product.useUntil.toLocal().toString()}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Kategoria ${product.categoryName}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
