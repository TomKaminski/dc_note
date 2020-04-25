import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

void safeAddToSink(Subject subject, Object valueToAdd) {
  if (subject == null || subject.isClosed) {
    debugPrint("Stream closed");
    return;
  }
  subject.sink.add(valueToAdd);
}
