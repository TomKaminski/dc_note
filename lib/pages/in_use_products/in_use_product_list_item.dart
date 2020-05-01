import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/modal/modal_with_actions_widget.dart';
import 'package:DC_Note/pages/add_product/add_product_screen.dart';
import 'package:DC_Note/pages/products/bloc/products_bloc.dart';
import 'package:DC_Note/pages/products/product_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/in_use_products_bloc.dart';

class InUseProductListItemWidget extends StatelessWidget {
  final ProductModel product;

  const InUseProductListItemWidget({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Card(
        elevation: 5,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          onTap: () async {
            final productBloc = BlocProvider.of<InUseProductsBloc>(context);
            showDialog(
              context: context,
              builder: (context) {
                return ProductDetailDialog(
                    product: product,
                    actions: buildModalActions(context, productBloc));
              },
            );
          },
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${product.quantity}x ${product.name}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
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
              SizedBox(height: 4),
              Text(
                product.category.title,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.black87),
              ),
              ...getDateUntilWidgets()
            ],
          ),
        ),
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
      BuildContext context, InUseProductsBloc productBloc) {
    final List<ModalActionItem> items = [];

    items.add(ModalActionItem(
        name: "Oznacz jako nieużywane",
        onPressed: () {
          productBloc.add(RemoveFromInUseProductsEvent(product.id));
        }));

    items.addAll([
      ModalActionItem(
          name: "Edytuj",
          onPressed: () async {
            Navigator.of(context).pop();
            final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => AddProductScreen(editModel: product)));

            if (result == true) {
              productBloc.add(LoadInUseProductsEvent(null));
            }
          }),
    ]);
    return items;
  }
}
