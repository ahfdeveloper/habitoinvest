import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:intl/intl.dart';

class ExpenseAddUpdateController extends GetxController {
  final TextEditingController dateTextFormFieldController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final FocusNode _myFocusNode = FocusNode();
  final List expenseQualityList = [
    'Essencial',
    'Não essencial, mas importante',
    'Não essencial'
  ];
  final _selectedExpenseQuality = 'Essencial'.obs;

  get selectedExpenseQuality => this._selectedExpenseQuality.value;
  set setSelectedExpenseQuality(value) =>
      this._selectedExpenseQuality.value = value;

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDate(BuildContext context) async {
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
      dateTextFormFieldController
        ..text = DateFormat('dd/MM/yyyy').format(newselectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateTextFormFieldController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  dynamic focusBox() {
    if (_myFocusNode.hasFocus) {
      return AppColors.expenseColor;
    }
  }
}

class ItemExpenseQuality {
  Icon? icon;
  String? nome;
}
