import 'package:flutter/material.dart';

import 'neuro_square_button.dart';

class AppBarButton extends NeumorphicSquareButton {
  AppBarButton.back()
      : super.appBar(
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
            onTap: (context) => Navigator.maybePop(context));
}
