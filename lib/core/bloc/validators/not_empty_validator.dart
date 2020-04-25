import 'dart:async';
import 'package:flutter/widgets.dart';

final notEmptyValidator =
    StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
  if (value == null || value.isEmpty) {
    sink.addError(BlocFormErrors.field_required);
  } else {
    sink.add(value);
  }
});

enum BlocFormErrors { field_required }

extension BlocFormErrorsExtension on BlocFormErrors {
  String localizeError(BuildContext context) {
    switch (this) {
      case BlocFormErrors.field_required:
        return "Pole jest wymagane.";
    }
    return "Nieznany błąd";
  }
}
