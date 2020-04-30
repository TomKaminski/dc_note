import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/modal/modal_action_widget.dart';
import 'package:DC_Note/core/widgets/modal/modal_with_actions_widget.dart';
import 'package:DC_Note/pages/add_product/add_product_screen.dart';
import 'package:DC_Note/pages/in_use_products/bloc/in_use_products_bloc.dart';
import 'package:DC_Note/pages/products/product_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InUseProductListItemWidget extends StatelessWidget {
  final ProductModel product;

  const InUseProductListItemWidget({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Card(
        color: AppColors.main,
        elevation: 3,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () async {
            final productBloc = BlocProvider.of<InUseProductsBloc>(context);
            showDialog(
              context: context,
              builder: (ctx) {
                return ProductDetailDialog(
                  product: product,
                  actions: buildModalActions(context, productBloc),
                );
              },
            );
          },
          onLongPress: () {
            final productBloc = BlocProvider.of<InUseProductsBloc>(context);
            showDialog(
              context: context,
              builder: (context) {
                return ModalActionWidget(
                  title: "Wybierz akcję",
                  description: null,
                  actions: buildModalActions(context, productBloc),
                );
              },
            );
          },
          title: Container(
            color: AppColors.main,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${product.name}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Ilość: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: Colors.black87)),
                          Text(product.quantity.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: AppColors.main)),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Kategoria",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.black87)),
                      SizedBox(
                        height: 6,
                      ),
                      buildCategorySubwidget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          product.useUntil != null
                              ? "Ważne do ${DateFormat.yMMMMd("PL").format(product.useUntil)}"
                              : "Brak daty ważności",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(children: buildInUseIndicator())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ModalActionItem> buildModalActions(
      BuildContext context, InUseProductsBloc productBloc) {
    final List<ModalActionItem> items = [];

    if (product.inUse) {
      items.add(ModalActionItem(
          name: "Oznacz jako nieużywane",
          onPressed: () {
            productBloc.add(RemoveFromInUseProductsEvent(product.id));
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
              productBloc.add(LoadInUseProductsEvent(null));
            }
          }),
    ]);
    return items;
  }

  List<Widget> buildInUseIndicator() {
    if (product.inUse) {
      return [
        Icon(
          Icons.stars,
          color: Colors.white,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          "Używane",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ];
    }
    return [];
  }

  Widget buildCategorySubwidget() {
    final List<Widget> items = [];
    if (product.category.icon != null) {
      items.addAll([
        ImageIcon(
          product.category.icon,
          size: 24,
          color: AppColors.main,
        ),
        SizedBox(width: 4),
      ]);
    }

    items.add(Text(product.category.title,
        maxLines: 3,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.black87)));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: items,
    );
  }
}
