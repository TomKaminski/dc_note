import 'package:flutter/material.dart';

class BaseFormElementTitleWidget extends StatelessWidget {
  const BaseFormElementTitleWidget({
    Key key,
    @required this.isRequired,
    @required this.title,
  }) : super(key: key);

  final bool isRequired;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (title == "")
          Container()
        else
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
        if (isRequired && title != "")
          Text(
            "*",
            style: TextStyle(
                color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
          )
        else
          Container()
      ],
    );
  }
}
