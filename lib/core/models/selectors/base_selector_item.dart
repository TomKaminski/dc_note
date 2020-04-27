import 'package:flutter/material.dart';

abstract class BaseSelectorItem {
  final String title;
  final int id;

  IconData get icon;

  BaseSelectorItem(this.title, this.id);

  static Widget getSelectorWidget(BaseSelectorItem item, bool isDisabled) {
    final List<Widget> items = [];
    if (item.icon != null) {
      items.addAll([
        Icon(item.icon),
        SizedBox(width: 4),
      ]);
    }

    items.add(Text(
      item.title,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: (isDisabled) ? Colors.black12 : Colors.black54),
    ));
    return Row(
      children: items,
    );
  }
}
