import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';

import 'neuro_square_button.dart';

class ListButton extends NeumorphicSquareButton {
  ListButton.favouriteSelected(void Function() onTap)
      : super.listItemSelected(
          child: Icon(
            Icons.star,
            color: AppColors.gold,
          ),
          onTap: (context) => onTap(),
        );

  ListButton.favouriteNotSelected(void Function() onTap)
      : super.listItemNotSelected(
            child: Icon(
              Icons.star_border,
              color: Colors.grey,
            ),
            onTap: (context) => onTap());

  ListButton.deleteProduct(void Function() onTap)
      : super.listItemNotSelected(
            child: Icon(
              Icons.delete,
              color: Colors.red,
              size: 16,
            ),
            onTap: (context) => onTap(),
            style: NeumorphicSquareButtonStyle.listItemNotSelected(
                buttonSize: 34, sizeWithPaddings: 40));

  ListButton.loadingSelected()
      : super.listItemSelected(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
            onTap: (_) {});

  ListButton.loadingNotSelected()
      : super.listItemNotSelected(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
            onTap: (_) {});
}
