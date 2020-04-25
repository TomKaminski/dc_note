import 'package:flutter/material.dart';

class ModalActionItem {
  final String name;
  final Color textColor;
  final Function() onPressed;

  const ModalActionItem(
      {this.name, this.onPressed, this.textColor = Colors.black});
}

class ModalActionItemWidget extends StatelessWidget {
  final ModalActionItem item;

  const ModalActionItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          onTap: item.onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                item.name,
                style: TextStyle(color: item.textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
