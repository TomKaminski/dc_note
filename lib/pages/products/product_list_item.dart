import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/modal/modal_action_widget.dart';
import 'package:DC_Note/core/widgets/modal/modal_with_actions_widget.dart';
import 'package:DC_Note/core/widgets/neuro/list_buttons.dart';
import 'package:DC_Note/pages/add_product/add_product_screen.dart';
import 'package:DC_Note/pages/products/bloc/products_bloc.dart';
import 'package:DC_Note/pages/products/product_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductListItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductListItemWidget({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final productBloc = BlocProvider.of<ProductsBloc>(context);
        showDialog(
          context: context,
          builder: (context) {
            return ProductDetailDialog(
                product: product,
                actions: buildModalActions(context, productBloc));
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListButton.favouriteNotSelected(() {}),
            SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "${product.quantity}x ${product.name}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 1),
              Text(
                product.category.title,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.black54),
              ),
              //...getDateUntilWidgets()
            ])
          ],
        ),
      ),
    );
    return ListTile(
      onTap: () async {
        final productBloc = BlocProvider.of<ProductsBloc>(context);
        showDialog(
          context: context,
          builder: (context) {
            return ProductDetailDialog(
                product: product,
                actions: buildModalActions(context, productBloc));
          },
        );
      },
      leading: ListButton.favouriteNotSelected(() {}),
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${product.quantity}x ${product.name}",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary),
            ),
            Visibility(
              visible: product.inUse,
              child: ImageIcon(
                AssetImage("assets/images/star.png"),
                color: AppColors.secondary,
              ),
            )
          ],
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            product.category.title,
            maxLines: 3,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: Colors.black87),
          ),
          //...getDateUntilWidgets()
        ],
      ),
    );
  }

  List<Widget> getDateUntilWidgets() {
    if (product.useUntil != null) {
      return [
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageIcon(
                  AssetImage("assets/images/hourglass.png"),
                  size: 18,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '${DateFormat.yMMMMd("PL").format(product.useUntil)}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        )
      ];
    }
    return [];
  }

  List<ModalActionItem> buildModalActions(
      BuildContext context, ProductsBloc productBloc) {
    final List<ModalActionItem> items = [];

    if (!product.inUse) {
      items.add(ModalActionItem(
          name: "Oznacz jako uzywane",
          onPressed: () {
            productBloc.add(ToggleInUseProductsEvent(product.id, true));
          }));
    } else {
      items.add(ModalActionItem(
          name: "Oznacz jako nieużywane",
          onPressed: () {
            productBloc.add(ToggleInUseProductsEvent(product.id, false));
          }));
    }

    items.addAll([
      ModalActionItem(
          name: "Edytuj",
          onPressed: () async {
            Navigator.of(context).pop();
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => AddProductScreen(editModel: product)));

            if (result == true) {
              productBloc.add(LoadProductsEvent(null));
            }
          }),
      ModalActionItem(
          name: "Usuń produkt",
          style: TextStyle(color: Colors.red),
          onPressed: () {
            productBloc.add(DeleteProductEvent(product.id));
          }),
    ]);
    return items;
  }
}
