import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';

import 'neuro_square_button.dart';

class ListButton extends NeumorphicSquareButton {
  ListButton.favouriteSelected(void Function() onTap)
      : super.listItemSelected(
          child: Icon(
            Icons.star,
            color: AppColors.secondary,
          ),
          onTap: (context) => onTap(),
        );

  ListButton.favouriteNotSelected(void Function() onTap)
      : super.listItemNotSelected(
            child: Icon(
              Icons.star_border,
              color: AppColors.secondary,
            ),
            onTap: (context) => onTap());

  ListButton.loadingSelected()
      : super.listItemSelected(
            child: CircularProgressIndicator(), onTap: (_) {});

  ListButton.loadingNotSelected()
      : super.listItemNotSelected(
            child: CircularProgressIndicator(), onTap: (_) {});
}
