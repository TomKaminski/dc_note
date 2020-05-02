import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';

abstract class BaseSelectorItem {
  final String title;
  final int id;

  AssetImage get icon;

  BaseSelectorItem(this.title, this.id);

  static Widget getSelectorWidget(BaseSelectorItem item, bool isDisabled) {
    final List<Widget> items = [];
    if (item.icon != null) {
      items.addAll([
        ImageIcon(
          item.icon,
          size: 28,
          color: AppColors.secondary,
        ),
        SizedBox(width: 4),
      ]);
    }

    items.add(Text(
      item.title,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: (isDisabled) ? Colors.black12 : AppColors.secondary),
    ));
    return Row(
      children: items,
    );
  }
}
