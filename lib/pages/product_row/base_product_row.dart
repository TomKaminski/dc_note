import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/modal/modal_with_actions_widget.dart';
import 'package:DC_Note/core/widgets/neuro/list_buttons.dart';
import 'package:DC_Note/pages/add_product/add_product_screen.dart';
import 'package:DC_Note/pages/product_row/bloc/product_row_bloc.dart';
import 'package:DC_Note/pages/products/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class BaseProductRowWidget extends StatefulWidget {
  final ProductModel product;
  final bool hideCategory;

  BaseProductRowWidget({Key key, @required this.product, this.hideCategory})
      : super(key: key);

  @override
  BaseProductRowWidgetState createState() => BaseProductRowWidgetState();
}

class BaseProductRowWidgetState extends State<BaseProductRowWidget> {
  ProductRowBloc bloc;

  void onProductAddEditCallback(BuildContext context, result) {
    final productBloc = BlocProvider.of<ProductsBloc>(context);
    if (result == true) {
      productBloc.add(LoadProductsEvent(null));
    }
  }

  void onDeleteConfirmCallback(BuildContext context) {
    final productBloc = BlocProvider.of<ProductsBloc>(context);
    productBloc.add(DeleteProductEvent(widget.product.id));
  }

  @override
  void initState() {
    super.initState();
    bloc = ProductRowBloc(widget.product.id, widget.product.inUse);
  }

  Widget buildInUseButton(bool inUse) {
    if (inUse) {
      return ListButton.favouriteSelected(
          () => bloc.add(ProductRowEventToggleInUse(false)));
    } else {
      return ListButton.favouriteNotSelected(
          () => bloc.add(ProductRowEventToggleInUse(true)));
    }
  }

  Widget buildDeleteButton() {
    return ListButton.deleteProduct(() {
      showDialog(
          context: context,
          child: AlertDialog(
            backgroundColor: AppColors.buttonsGrey,
            content: Text("Na pewno usunąć produkt?"),
            actions: [
              NeumorphicButton(
                child: Text("Usuń"),
                style: NeumorphicStyle(color: Colors.red),
                onClick: () {
                  onDeleteConfirmCallback(context);
                  Navigator.of(context).pop();
                },
              ),
              NeumorphicButton(
                child: Text("Anuluj"),
                onClick: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
    });
  }

  Widget buildLoading(bool inUse) {
    if (inUse) {
      return ListButton.loadingNotSelected();
    } else {
      return ListButton.loadingSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddProductScreen(editModel: widget.product)));

        onProductAddEditCallback(context, result);
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ProductRowBloc, ProductRowState>(
                      bloc: bloc,
                      builder: (ctx, state) {
                        if (state.isProcessing) {
                          return buildLoading(state.data);
                        }
                        return buildInUseButton(state.data);
                      }),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.product.quantity}x ${widget.product.name}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          SizedBox(height: 1),
                          Visibility(
                            visible: !widget.hideCategory,
                            child: Text(
                              widget.product.category.title,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: Colors.black54),
                            ),
                          ),
                          if (widget.product.useUntil != null)
                            Text(
                              'ważne do ${DateFormat.yMMMMd("PL").format(widget.product.useUntil)}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                            ),
                          if (widget.product.reviewed == true)
                            Text(
                              'przetestowane',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700),
                            )
                        ]),
                  ),
                  buildDeleteButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
