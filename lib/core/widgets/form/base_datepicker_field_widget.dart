import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BaseDatePickerFieldWidget extends StatefulWidget {
  final DateTime initialData;
  final BehaviorBlocField<DateTime> blocField;
  final Stream<bool> disabledStream;
  final bool isDisabled;
  final String title;
  final bool isRequired;
  final Widget suffix;
  final Image prefixImage;

  const BaseDatePickerFieldWidget(
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
  _BaseDatePickerFieldWidgetState createState() =>
      _BaseDatePickerFieldWidgetState();
}

class _BaseDatePickerFieldWidgetState extends State<BaseDatePickerFieldWidget> {
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
                  opacity: widget.blocField.value == null ? 0 : 1,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      if (isDisabled || widget.isDisabled) {
                        return;
                      }
                      final selectedDate = await showDatePicker(
                          builder: (ctx, child) {
                            return Theme(
                                data: ThemeData(primarySwatch: Colors.teal),
                                child: child);
                          },
                          cancelText: "Anuluj",
                          confirmText: "Wybierz",
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().add(Duration(days: -30)),
                          lastDate: DateTime(2099));

                      widget.blocField.onChanged(selectedDate);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(_getTextValue(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: (isDisabled || widget.isDisabled)
                                      ? Colors.black12
                                      : widget.blocField.value != null
                                          ? AppColors.secondary
                                          : Colors.black87)),
                          SizedBox(
                            height: 12,
                          ),
                          Container(height: 2, color: Colors.black45)
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
  }

  String _getTextValue() {
    if (widget.blocField.value != null) {
      return DateFormat.yMMMMd("PL").format(widget.blocField.value);
    } else {
      return widget.title;
    }
  }
}
