import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:DC_Note/core/models/selectors/base_selector_item.dart';
import 'package:DC_Note/pages/category_selector/category_screen.dart';
import 'package:flutter/material.dart';

class BaseSelectorFieldWidget<T extends BaseSelectorItem>
    extends StatefulWidget {
  final DateTime initialData;
  final BehaviorBlocField<T> blocField;
  final Stream<bool> disabledStream;
  final bool isDisabled;
  final String title;
  final bool isRequired;
  final Widget suffix;
  final Image prefixImage;

  const BaseSelectorFieldWidget(
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
  _BaseSelectorFieldWidgetState<T> createState() =>
      _BaseSelectorFieldWidgetState<T>();
}

class _BaseSelectorFieldWidgetState<T> extends State<BaseSelectorFieldWidget> {
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
                      final T result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => CategorySelectorScreen()));

                      if (result == null) {
                        return;
                      }

                      widget.blocField.onChanged(result);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          getItemWidget(isDisabled),
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

  Widget getItemWidget(bool isDisabled) {
    final disabled = isDisabled || widget.isDisabled;
    if (widget.blocField.value != null) {
      return BaseSelectorItem.getSelectorWidget(
          widget.blocField.value, disabled);
    } else {
      return Text(widget.blocField.value?.toString() ?? widget.title,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: disabled ? Colors.black12 : Colors.black54));
    }
  }
}
