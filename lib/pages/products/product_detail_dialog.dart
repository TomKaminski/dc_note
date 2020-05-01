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
                  "${product.quantity.toString()}x ${product.name}",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: product.inUse,
                          child: TitleWithValue(
                            icon: ImageIcon(
                                AssetImage("assets/images/star.png"),
                                color: AppColors.secondary,
                                size: 28),
                            title: "w użyciu",
                            value: null,
                          ),
                        ),
                        TitleWithValue(
                          icon: ImageIcon(
                            product.category.icon,
                            size: 30,
                            color: AppColors.secondary,
                          ),
                          title: "Kategoria",
                          value: product.category.title,
                        ),
                        TitleWithValue(
                          icon: Icon(
                            Icons.access_time,
                            color: AppColors.secondary,
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
                            color: AppColors.secondary,
                            size: 30,
                          ),
                          title: "Notatki",
                          value: product.notes ?? "Brak notatek",
                        ),
                        Divider()
                      ],
                    ),
                  )),
              ...actions
                  .map((e) => Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                          child: ModalActionItemWidget(
                            item: e,
                          ),
                        ),
                      ))
                  .toList(),
              SizedBox(
                height: 36,
              )
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
    List<Widget> items = [
      Divider(),
      SizedBox(height: 2),
      Row(
        children: [
          icon,
          SizedBox(width: 4),
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
      SizedBox(height: 2)
    ];

    if (value != null) {
      items.add(
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}
