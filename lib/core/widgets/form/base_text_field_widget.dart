import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextFieldWidget extends StatefulWidget {
  final String initialData;
  final BehaviorBlocField<String> blocField;
  final Stream<bool> disabledStream;
  final bool isDisabled;
  final String title;
  final bool isRequired;
  final Widget suffix;
  final bool multiLine;
  final bool onlyNumbers;
  final bool obscureText;

  ///to use this onlyNumbers must be set to true
  final bool allowFloatingPoint;
  final Image prefixImage;

  const BaseTextFieldWidget(
      {Key key,
      @required this.blocField,
      @required this.initialData,
      @required this.isRequired,
      this.title = "",
      this.suffix,
      this.onlyNumbers = false,
      this.allowFloatingPoint = false,
      this.obscureText = false,
      this.prefixImage,
      this.disabledStream,
      this.isDisabled = false,
      this.multiLine = false})
      : super(key: key);

  @override
  _BaseTextFieldWidgetState createState() => _BaseTextFieldWidgetState();
}

class _BaseTextFieldWidgetState extends State<BaseTextFieldWidget> {
  TextEditingController _controller;
  String inputError;
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = TextEditingController(text: widget.initialData);

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
    return StreamBuilder<bool>(
        stream: widget.disabledStream ?? Stream.value(false),
        builder: (context, snapshot) {
          final isDisabled = snapshot.data == true;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: _controller.value.text.isEmpty ? 0 : 1,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                    minLines: 1,
                    maxLines: 8,
                    enabled: !isDisabled && !widget.isDisabled,
                    controller: _controller,
                    onChanged: widget.blocField.onChanged,
                    style: TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: (isDisabled || widget.isDisabled)
                            ? Colors.black12
                            : AppColors.secondary),
                    cursorColor: Colors.grey,
                    obscureText: _obscureText,
                    keyboardType: widget.onlyNumbers
                        ? TextInputType.numberWithOptions(
                            decimal: widget.allowFloatingPoint)
                        : widget.multiLine
                            ? TextInputType.multiline
                            : TextInputType.text,
                    inputFormatters: widget.onlyNumbers
                        ? widget.allowFloatingPoint
                            ? [
                                WhitelistingTextInputFormatter(RegExp(
                                    r"[+-]?([0-9]+([,][0-9]*)?|[,][0-9]+)")),
                              ]
                            : [WhitelistingTextInputFormatter.digitsOnly]
                        : [],
                    decoration: InputDecoration(
                        errorText: inputError,
                        disabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black12)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black45)),
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        contentPadding: EdgeInsets.all(0),
                        suffix: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: widget.suffix,
                        ),
                        hintText: widget.title,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)))
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
