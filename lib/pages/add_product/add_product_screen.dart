import 'package:DC_Note/core/bloc/boolean_state.dart';
import 'package:DC_Note/core/models/product_model.dart';
import 'package:DC_Note/core/statics/adds.dart';
import 'package:DC_Note/core/statics/application.dart';
import 'package:DC_Note/core/statics/colors.dart';
import 'package:DC_Note/core/widgets/form/base_checkbox_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_datepicker_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_form_submit_button.dart';
import 'package:DC_Note/core/widgets/form/base_selector_field_widget.dart';
import 'package:DC_Note/core/widgets/form/base_text_field_widget.dart';
import 'package:DC_Note/core/widgets/neuro/app_bar_buttons.dart';
import 'package:DC_Note/pages/add_product/bloc/add_product_bloc.dart';
import 'package:DC_Note/pages/category_selector/category_selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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

    if (Application.showedFullscreenAdd == false) {
      Application.showedFullscreenAdd = true;
      AppAds.showFullscreen(state: this);
    }
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
        leading: AppBarButton.back(),
        title: Text(
          widget.editModel != null ? "Edytuj produkt" : "Dodaj produkt",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
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
                    if (widget.editModel == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Dodaj produkt wypełniając odpowiednie pola. Data ważności, notatki oraz pole "Aktualnie używam" są opcjonalne. W każdej chwili możesz je zmienić w widoku edycji produktu.',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              height: 1.6),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Edytuj produkt zmieniając odpowiednie pola. Data ważności, notatki oraz pole "Aktualnie używam" są opcjonalne. Jeżeli chcesz usunąć produkt wybierz odpowiedni przycisk poniżej.',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
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
                        multiLine: true,
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
                        isRequired: false),
                    BaseCheckboxFieldWidget(
                        title: "Przetestowane",
                        isDisabled: currentState.isProcessing,
                        blocField: bloc.reviewedField,
                        initialData: bloc.reviewedField.value,
                        isRequired: false),
                    SizedBox(height: 12),
                    FormSubmitButton(
                      disabledStream: bloc.isFormValid,
                      isDisabled: currentState.isProcessing,
                      onPressed: () => bloc.add(AddProductEvent()),
                      text: "Zapisz produkt",
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
