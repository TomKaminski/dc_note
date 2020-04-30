import 'dart:async';

import 'package:DC_Note/core/bloc/bloc_field.dart';
import 'package:DC_Note/core/bloc/boolean_state.dart';
import 'package:DC_Note/core/bloc/validators/not_empty_validator.dart';
import 'package:DC_Note/core/models/app_error.dart';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/models/selectors/category_selector_item.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/database/app_database.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'add_product_event.dart';

class AddProductBloc extends Bloc<AddProductEvent, BooleanState> {
  final int id;

  final nameField = BehaviorBlocField(
      streamModifing: (stream) => stream.transform(notEmptyValidator));
  final quantityField = BehaviorBlocField(
      streamModifing: (stream) => stream.transform(notEmptyValidator));

  final notesField = BehaviorBlocField<String>();
  final inUseField = BehaviorBlocField<bool>();
  final useUntilField = BehaviorBlocField<DateTime>();

  final categoryField = BehaviorBlocField<CategorySelectorItem>(
    streamModifing: (stream) => stream.transform(
      StreamTransformer<CategorySelectorItem,
          CategorySelectorItem>.fromHandlers(handleData: (value, sink) {
        if (value == null) {
          sink.addError(BlocFormErrors.field_required);
        } else {
          sink.add(value);
        }
      }),
    ),
  );

  AddProductBloc(ProductModel product) : id = product?.id {
    if (product != null) {
      nameField.emit(product.name);
      quantityField.emit(product.quantity.toString());
      inUseField.emit(product.inUse);
      notesField.emit(product.notes);
      useUntilField.emit(product.useUntil);
      categoryField.emit(product.category);
    }
  }

  Stream<bool> get isFormValid =>
      Rx.combineLatest2(nameField.stream, quantityField.stream, (a, b) => true);

  @override
  BooleanState get initialState => BooleanState.notProcessing();

  @override
  Stream<BooleanState> mapEventToState(
    AddProductEvent event,
  ) async* {
    yield BooleanState.processing();
    try {
      if (id != null) {
        await Application.database.productDao.updateItem(ProductEntity(
            name: nameField.value,
            quantity: int.parse(quantityField.value),
            categoryId: categoryField.value.id,
            useUntil: useUntilField.value,
            notes: notesField.value,
            id: id,
            inUse: inUseField.value ?? false));
      } else {
        await Application.database.productDao.insert(ProductEntity(
            name: nameField.value,
            quantity: int.parse(quantityField.value),
            categoryId: categoryField.value.id,
            useUntil: useUntilField.value,
            notes: notesField.value,
            id: null,
            inUse: inUseField.value ?? false));
      }

      yield BooleanState.successful();
    } catch (error) {
      yield BooleanState.error(AppError("Nie udało się zapisać produktu."));
    }
  }
}
