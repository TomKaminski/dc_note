import 'dart:async';

import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/boolean_state.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:DC_Note/core/models/app_error.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/database/app_database.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'add_product_event.dart';

class AddProductBloc extends Bloc<AddProductEvent, BooleanState> {
  final nameField = BehaviorBlocField(
      streamModifing: (stream) => stream.transform(notEmptyValidator));
  final quantityField = BehaviorBlocField(
      streamModifing: (stream) => stream.transform(notEmptyValidator));
  final amountPerItemField = BehaviorBlocField(
      streamModifing: (stream) => stream.transform(notEmptyValidator));
  final amountSuffixField = BehaviorBlocField(
      streamModifing: (stream) => stream.transform(notEmptyValidator));
  final useUntilField = BehaviorBlocField<DateTime>();

  Stream<bool> get isFormValid => Rx.combineLatest4(
      nameField.stream,
      quantityField.stream,
      amountPerItemField.stream,
      amountSuffixField.stream,
      (a, b, c, d) => true);

  @override
  BooleanState get initialState => BooleanState.notProcessing();

  @override
  Stream<BooleanState> mapEventToState(
    AddProductEvent event,
  ) async* {
    yield BooleanState.processing();
    try {
      await Application.database.productDao.insert(ProductEntity(
          name: nameField.value,
          amountPerItem: double.parse(amountPerItemField.value),
          amountSuffixKey: amountSuffixField.value,
          quantity: double.parse(quantityField.value),
          categoryId: 1,
          useUntil: DateTime.now(),
          id: null));
      yield BooleanState.successful();
    } catch (error) {
      yield BooleanState.error(AppError("Nie udało się zapisać produktu."));
    }
  }
}
