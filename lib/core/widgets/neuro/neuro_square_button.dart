import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicSquareButtonStyle {
  final double sizeWithPaddings;
  final double buttonSize;
  final double iconSize;
  final double borderRadius;
  final NeumorphicStyle neumorphicStyle;

  const NeumorphicSquareButtonStyle.appBarButton(
      {this.sizeWithPaddings = 54.0,
      this.buttonSize = 34.0,
      this.iconSize = 22.0,
      this.borderRadius = 8.0,
      this.neumorphicStyle = const NeumorphicStyle(
          color: Color.fromARGB(255, 235, 236, 240), depth: 10)});

  const NeumorphicSquareButtonStyle.listItemSelected(
      {this.sizeWithPaddings = 40.0,
      this.buttonSize = 40.0,
      this.iconSize = 24.0,
      this.borderRadius = 8.0,
      this.neumorphicStyle = const NeumorphicStyle(
          color: Color.fromARGB(255, 235, 236, 240), depth: -5)});

  const NeumorphicSquareButtonStyle.listItemNotSelected(
      {this.sizeWithPaddings = 40.0,
      this.buttonSize = 40.0,
      this.iconSize = 24.0,
      this.borderRadius = 8.0,
      this.neumorphicStyle = const NeumorphicStyle(
          color: Color.fromARGB(255, 235, 236, 240), depth: 5)});
}

class NeumorphicSquareButton extends StatelessWidget {
  final void Function(BuildContext) onTap;
  final NeumorphicSquareButtonStyle style;
  final Widget child;

  const NeumorphicSquareButton.appBar(
      {@required this.child,
      @required this.onTap,
      this.style = const NeumorphicSquareButtonStyle.appBarButton()})
      : assert(onTap != null),
        assert(child != null),
        assert(style != null);
  const NeumorphicSquareButton.listItemSelected(
      {@required this.child,
      @required this.onTap,
      this.style = const NeumorphicSquareButtonStyle.listItemSelected()})
      : assert(onTap != null),
        assert(child != null),
        assert(style != null);
  const NeumorphicSquareButton.listItemNotSelected(
      {@required this.child,
      @required this.onTap,
      this.style = const NeumorphicSquareButtonStyle.listItemNotSelected()})
      : assert(onTap != null),
        assert(child != null),
        assert(style != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style.sizeWithPaddings,
      height: style.sizeWithPaddings,
      child: Center(
          child: Container(
        height: style.buttonSize,
        width: style.buttonSize,
        child: NeumorphicButton(
            onClick: () {
              onTap(context);
            },
            style: style.neumorphicStyle,
            padding: const EdgeInsets.all(8),
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(style.borderRadius)),
            isEnabled: true,
            child: Center(
              child: Container(
                width: style.iconSize,
                height: style.iconSize,
                child: child,
              ),
            )),
      )),
    );
  }
}
