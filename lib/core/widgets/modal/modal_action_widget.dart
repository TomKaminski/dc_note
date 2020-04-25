import 'package:flutter/material.dart';
import 'modal_with_actions_widget.dart';

class ModalActionWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<ModalActionItem> actions;

  const ModalActionWidget({Key key, this.actions, this.title, this.description})
      : super(key: key);

  @override
  ModalActionWidgetState createState() {
    return ModalActionWidgetState();
  }
}

class ModalActionWidgetState extends State<ModalActionWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: widget.actions
                        .map((e) => ModalActionItemWidget(
                              item: e,
                            ))
                        .toList(),
                  ),
                )),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
