import 'package:flutter/material.dart';

import '../gradient_circular_button.dart';

class ModalActionItem {
  final String name;
  final TextStyle style;
  final Function() onPressed;

  const ModalActionItem({this.name, this.onPressed, this.style});
}

class ModalActionItemWidget extends StatelessWidget {
  final ModalActionItem item;

  const ModalActionItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientCircularButton(
      disabled: false,
      gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 1.0]),
      onPressed: item.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            item.name,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }
}
