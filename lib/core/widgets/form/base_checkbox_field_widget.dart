import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';

class BaseCheckboxFieldWidget extends StatefulWidget {
  final bool initialData;
  final BehaviorBlocField<bool> blocField;
  final Stream<bool> disabledStream;
  final bool isDisabled;
  final String title;
  final bool isRequired;
  final Widget suffix;
  final Image prefixImage;

  const BaseCheckboxFieldWidget(
      {Key key,
      @required this.blocField,
      @required this.initialData,
      @required this.isRequired,
      this.title = "",
      this.suffix,
      this.prefixImage,
      this.disabledStream,
      this.isDisabled = false})
      : super(key: key);

  @override
  _BaseCheckboxFieldWidgetState createState() =>
      _BaseCheckboxFieldWidgetState();
}

class _BaseCheckboxFieldWidgetState extends State<BaseCheckboxFieldWidget> {
  String inputError;

  @override
  void initState() {
    super.initState();
    widget?.blocField?.stream?.listen((data) {
      setState(() {
        inputError = null;
      });
    }, onError: (error) {
      setState(() {
        inputError = (error as BlocFormErrors).localizeError(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.disabledStream ?? Stream.value(false),
        builder: (context, snapshot) {
          final isDisabled = snapshot.data == true;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: GestureDetector(
              onTap: () {
                if (!isDisabled) {
                  widget.blocField.emit(!widget.blocField.value);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: (widget.blocField.value ?? false)
                            ? AppColors.main
                            : Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                      value: widget.blocField.value ?? false,
                      onChanged:
                          isDisabled ? null : widget.blocField.onChanged),
                ],
              ),
            ),
          );
        });
  }
}
