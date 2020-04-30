import 'package:flutter/material.dart';

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
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        onTap: item.onPressed,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              item.name,
              style: item.style ?? TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
