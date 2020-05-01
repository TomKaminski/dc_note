import 'package:flutter/material.dart';

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
          return GradientCircularButton(
            disabled: snapshot.data != true || isDisabled,
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).accentColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.2, 1.0]),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          );
        });
  }
}
