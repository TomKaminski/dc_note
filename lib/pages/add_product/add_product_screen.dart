import 'package:DC_Note/core/bloc/boolean_state.dart';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/form/base_checkbox_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_datepicker_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_form_submit_button.dart';
import 'package:DC_Note/core/widgets/form/base_selector_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_text_field_widget.dart';
import 'package:DC_Note/pages/add_product/bloc/add_product_bloc.dart';
import 'package:DC_Note/pages/category_selector/category_selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  final ProductModel editModel;

  const AddProductScreen({Key key, this.editModel}) : super(key: key);

  @override
  AddProductScreenState createState() {
    return AddProductScreenState();
  }
}

class AddProductScreenState extends State<AddProductScreen> {
  AddProductBloc bloc;
  @override
  void initState() {
    bloc = AddProductBloc(widget.editModel);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.editModel != null ? "Edytuj produkt" : "Dodaj produkt",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocConsumer<AddProductBloc, BooleanState>(
        bloc: bloc,
        builder: (
          BuildContext context,
          BooleanState currentState,
        ) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Dodaj produkt wypełniając odpowiednie pola. Data ważności, notatki oraz pole "Aktualnie używam" są opcjonalne. W każdej chwili możesz je zmienić w widoku edycji produktu.',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            height: 1.6),
                      ),
                    ),
                    BaseTextFieldWidget(
                        title: "Nazwa produktu",
                        blocField: bloc.nameField,
                        isDisabled: currentState.isProcessing,
                        initialData: bloc.nameField.value,
                        isRequired: true),
                    BaseTextFieldWidget(
                        blocField: bloc.notesField,
                        title: "Notatki",
                        isDisabled: currentState.isProcessing,
                        initialData: bloc.notesField.value,
                        isRequired: false),
                    BaseTextFieldWidget(
                        blocField: bloc.quantityField,
                        title: "Ilość",
                        onlyNumbers: true,
                        isDisabled: currentState.isProcessing,
                        initialData: bloc.quantityField.value,
                        isRequired: true),
                    BaseSelectorFieldWidget(
                      title: "Kategoria",
                      isDisabled: currentState.isProcessing,
                      blocField: bloc.categoryField,
                      initialData: null,
                      isRequired: true,
                      onSelectorScreenCreate: () => CategorySelectorPage(
                        title: "Wybierz kategorię",
                      ),
                    ),
                    BaseDatePickerFieldWidget(
                        title: "Data ważnosci",
                        isDisabled: currentState.isProcessing,
                        blocField: bloc.useUntilField,
                        initialData: bloc.useUntilField.value,
                        isRequired: true),
                    BaseCheckboxFieldWidget(
                        title: "Aktualnie używam",
                        isDisabled: currentState.isProcessing,
                        blocField: bloc.inUseField,
                        initialData: bloc.inUseField.value,
                        isRequired: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: FormSubmitButton(
                        disabledStream: bloc.isFormValid,
                        isDisabled: currentState.isProcessing,
                        onPressed: () => bloc.add(AddProductEvent()),
                        text: "Zapisz produkt",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, BooleanState state) {
          if (state.error != null) {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error.message),
            ));
          } else if (state.isSuccessful) {
            Navigator.pop(context, true);
          }
        },
      ),
    );
  }
}
