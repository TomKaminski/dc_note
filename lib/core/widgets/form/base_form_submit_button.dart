import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../gradient_circular_button.dart';

class FormSubmitButton extends StatelessWidget {
  final Stream<bool> disabledStream;
  final bool isDisabled;
  final Function() onPressed;
  final String text;

  const FormSubmitButton(
      {Key key,
      @required this.onPressed,
      @required this.text,
      this.disabledStream,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: disabledStream ?? Stream.value(false),
        builder: (context, snapshot) {
          final disabled = snapshot.data != true || isDisabled;
          return NeumorphicButton(
            style: NeumorphicStyle(
                color: disabled ? AppColors.buttonsGrey : AppColors.primary,
                shadowLightColorEmboss: disabled ? Colors.black54 : null,
                depth: -10),
            onClick: () {
              if (!disabled) {
                onPressed();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          );
        });
  }
}
