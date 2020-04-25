import 'package:flutter/material.dart';

class GradientCircularButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double height;
  final Function() onPressed;
  final bool disabled;

  const GradientCircularButton({
    Key key,
    @required this.child,
    this.gradient,
    this.height = 60.0,
    this.onPressed,
    this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: null,
            gradient: gradient,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Material(
          color: Colors.transparent,
          child: !disabled
              ? InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onTap: onPressed,
                  child: Center(
                    child: child,
                  ))
              : Center(
                  child: child,
                ),
        ),
      ),
    );
  }
}
