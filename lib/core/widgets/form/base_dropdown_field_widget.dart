import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:flutter/material.dart';

class BaseDropdownFieldWidget extends StatefulWidget {
  final String initialData;
  final BehaviorBlocField<String> blocField;
  final Stream<bool> disabledStream;
  final bool isDisabled;
  final String title;
  final bool isRequired;
  final List<String> values;
  final Widget suffix;
  final Image prefixImage;

  const BaseDropdownFieldWidget(
      {Key key,
      @required this.blocField,
      @required this.initialData,
      @required this.isRequired,
      this.title = "",
      this.suffix,
      this.prefixImage,
      @required this.values,
      this.disabledStream,
      this.isDisabled = false})
      : super(key: key);

  @override
  _BaseDropdownFieldWidgetState createState() =>
      _BaseDropdownFieldWidgetState();
}

class _BaseDropdownFieldWidgetState extends State<BaseDropdownFieldWidget> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedOpacity(
                  opacity: widget.blocField.value?.isEmpty != false ? 0 : 1,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ButtonTheme(
                  textTheme: ButtonTextTheme.normal,
                  padding: EdgeInsets.all(0),
                  child: DropdownButton<String>(
                      disabledHint: Text(widget.blocField.value ?? widget.title,
                          style: TextStyle(
                              color: (isDisabled || widget.isDisabled)
                                  ? Colors.black12
                                  : Colors.black54)),
                      value: widget.blocField.value,
                      hint: Text(widget.title),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: (isDisabled || widget.isDisabled)
                              ? Colors.black12
                              : Colors.black54),
                      onChanged: (isDisabled || widget.isDisabled)
                          ? null
                          : widget.blocField.onChanged,
                      dropdownColor: Colors.white,
                      items: widget.values
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      itemHeight: 60,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: (isDisabled || widget.isDisabled)
                            ? Colors.black12
                            : Colors.black45,
                      )),
                ),
              ],
            ),
          );
        });
  }
}
