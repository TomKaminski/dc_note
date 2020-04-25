import 'dart:async';

import 'package:DC_Note/core/bloc/safe_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBlocField<T, TSubject extends Subject<T>> {
  Stream<T> _stream;
  TSubject _controller;

  Stream<T> get stream => _stream;
  EventSink<T> get sink => _controller.sink;
  Stream<T> get rawStream => _controller.stream;

  ///Place to provide additonal info of this bloc field.
  dynamic tag;

  Function(dynamic) get onChanged => (event) {
        safeAddToSink(_controller, event);
      };

  BaseBlocField(
      {@required TSubject controller,
      Stream<T> Function(Stream<T>) streamModifing,
      this.tag}) {
    _controller = controller;
    _stream = controller.stream;
    if (streamModifing != null) {
      _stream = streamModifing(_controller.stream);
    }
  }

  ///Ads event to controller sink
  void emit(T event) => safeAddToSink(_controller, event);

  void close() => _controller?.close();
}

class BehaviorBlocField<T> extends BaseBlocField<T, BehaviorSubject<T>> {
  BehaviorBlocField({Stream<T> Function(Stream<T>) streamModifing, dynamic tag})
      : super(
            controller: BehaviorSubject<T>(),
            streamModifing: streamModifing,
            tag: tag);

  T get value => _controller.value;
}

class PublishBlocField<T> extends BaseBlocField<T, PublishSubject<T>> {
  PublishBlocField({Stream<T> Function(Stream<T>) streamModifing, dynamic tag})
      : super(
            controller: PublishSubject<T>(),
            streamModifing: streamModifing,
            tag: tag);
}
