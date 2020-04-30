import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/modal/modal_with_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailDialog extends StatelessWidget {
  final ProductModel product;
  final List<ModalActionItem> actions;

  const ProductDetailDialog({Key key, this.product, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  product.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.apps,
                                color: AppColors.main,
                                size: 30,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Ilość: ${product.quantity.toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 1,
                                      color: Colors.black87)),
                            ]),
                            Row(children: buildInUseIndicator()),
                          ],
                        ),
                        TitleWithValue(
                          icon: ImageIcon(
                            product.category.icon,
                            size: 30,
                            color: AppColors.main,
                          ),
                          title: "Kategoria",
                          value: product.category.title,
                        ),
                        TitleWithValue(
                          icon: Icon(
                            Icons.access_time,
                            color: AppColors.main,
                            size: 30,
                          ),
                          title: "Data ważności",
                          value: product.useUntil != null
                              ? "${DateFormat.yMMMMd("PL").format(product.useUntil)}"
                              : "brak",
                        ),
                        TitleWithValue(
                          icon: Icon(
                            Icons.event_note,
                            color: AppColors.main,
                            size: 30,
                          ),
                          title: "Notatki",
                          value: product.notes ?? "Brak notatek",
                        ),
                      ],
                    ),
                  )),
              ...actions
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: ModalActionItemWidget(
                          item: e,
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  List<Widget> buildInUseIndicator() {
    if (product.inUse) {
      return [
        Icon(Icons.stars, color: AppColors.main, size: 30),
        SizedBox(
          width: 4,
        ),
        Text(
          "w użyciu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ];
    }
    return [];
  }
}

class TitleWithValue extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;

  const TitleWithValue({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Row(
          children: [
            icon,
            SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
