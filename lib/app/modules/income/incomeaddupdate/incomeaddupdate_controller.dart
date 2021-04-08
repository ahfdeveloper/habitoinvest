import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class IncomeAddUpdateController extends GetxController {
  final TextEditingController dateTextFormFieldController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDate(BuildContext context) async {
    DateTime newselectedDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child){
        return Theme(
          data: ThemeData.from(colorScheme: ColorScheme.light(primary: INCOMECOLOR)),     
          child: child
        );
      }    
    );

    if(newselectedDate != null){
      dateTextFormFieldController
        ..text = DateFormat('dd/MM/yyyy').format(newselectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateTextFormFieldController.text.length,
            affinity: TextAffinity.upstream));
    }
  } 


}