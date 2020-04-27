import 'package:DC_Note/core/bloc/boolean_state.dart';
import 'package:DC_Note/core/widgets/form/base_checkbox_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_datepicker_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_form_submit_button.dart';
import 'package:DC_Note/core/widgets/form/base_selector_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_text_field_widget.dart';
import 'package:DC_Note/pages/add_product/bloc/add_product_bloc.dart';
import 'package:DC_Note/pages/category_selector/category_selector_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  @override
  AddProductScreenState createState() {
    return AddProductScreenState();
  }
}

class AddProductScreenState extends State<AddProductScreen> {
  final AddProductBloc bloc = AddProductBloc();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "Dodaj produkt",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      )),
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
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Dodaj produkt wypełniając odpowiednie pola.",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.6),
                      ),
                    ),
                    BaseTextFieldWidget(
                        title: "Nazwa produktu",
                        blocField: bloc.nameField,
                        isDisabled: currentState.isProcessing,
                        initialData: null,
                        isRequired: true),
                    BaseTextFieldWidget(
                        blocField: bloc.quantityField,
                        title: "Ilość",
                        isDisabled: currentState.isProcessing,
                        initialData: null,
                        isRequired: true),
                    BaseSelectorFieldWidget(
                      title: "Kategoria",
                      isDisabled: currentState.isProcessing,
                      blocField: bloc.categoryField,
                      initialData: null,
                      isRequired: true,
                      onSelectorScreenCreate: () => CategorySelectorScreen(
                        title: "Wybierz kategorię",
                      ),
                    ),
                    BaseDatePickerFieldWidget(
                        title: "Data waznosci",
                        isDisabled: currentState.isProcessing,
                        blocField: bloc.useUntilField,
                        initialData: null,
                        isRequired: true),
                    BaseCheckboxFieldWidget(
                        title: "Aktualnie używam?",
                        isDisabled: currentState.isProcessing,
                        blocField: bloc.inUseField,
                        initialData: false,
                        isRequired: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: FormSubmitButton(
                        disabledStream: bloc.isFormValid,
                        isDisabled: currentState.isProcessing,
                        onPressed: () => bloc.add(AddProductEvent()),
                        text: "Dodaj produkt",
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
