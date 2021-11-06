import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:intl/intl.dart';

class ExpenseAddUpdateController extends GetxController {
  final TextEditingController dateRegisterTextFormFieldController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final TextEditingController dateInstallmentsTextFormFieldController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final TextEditingController dateNoInstallmentsFormFieldController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final List expenseQualityList = [
    'Essencial',
    'Não essencial, mas importante',
    'Não essencial'
  ];
  final _selectedExpenseQuality = 'Essencial'.obs;

  RxString _installmentsType = ''.obs;
  String get installmentsType => this._installmentsType.value;
  set installmentsType(String value) {
    _installmentsType.update((val) {
      _installmentsType.value = value;
    });
  }

  bool visibilityInstallmentsYes = false;
  bool visibilityInstallmentsNo = false;

  get selectedExpenseQuality => this._selectedExpenseQuality.value;
  set setSelectedExpenseQuality(value) =>
      this._selectedExpenseQuality.value = value;

  Color? _containerRadioSimColor;
  Color? get containerRadioSimColor => this._containerRadioSimColor;
  set containerRadioSimColor(Color? value) =>
      this._containerRadioSimColor = value;

  Color? _containerRadioNaoColor;
  Color? get containerRadioNaoColor => this._containerRadioNaoColor;
  set containerRadioNaoColor(Color? value) =>
      this._containerRadioNaoColor = value;

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDate(
      {required BuildContext context,
      required TextEditingController textFormFieldController}) async {
    DateTime? newselectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.from(
                  colorScheme:
                      ColorScheme.light(primary: AppColors.expenseColor)),
              child: child!);
        });

    if (newselectedDate != null) {
      textFormFieldController
        ..text = DateFormat('dd/MM/yyyy').format(newselectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textFormFieldController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  // Muda a cor do container do tipo de categoria
  void paintContainerType() {
    if (installmentsType == 'Sim') {
      containerRadioSimColor = AppColors.grey300;
      containerRadioNaoColor = null;
    } else if (installmentsType == 'Não') {
      containerRadioSimColor = null;
      containerRadioNaoColor = AppColors.grey300;
    } else {
      containerRadioSimColor = null;
      containerRadioNaoColor = null;
    }
  }

  // dynamic focusBox() {
  //   if (_myFocusNode.hasFocus) {
  //     return AppColors.expenseColor;
  //   }
  // }
}

class ItemExpenseQuality {
  Icon? icon;
  String? nome;
}
