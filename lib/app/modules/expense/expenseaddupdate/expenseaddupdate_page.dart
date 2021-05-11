import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_controller.dart';

class ExpenseAddUpdatePage extends StatelessWidget {
  final ExpenseAddUpdateController _controller = ExpenseAddUpdateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.expenseColor,
        title: Text('Cadastrar Despesa'),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.cancel, color: AppColors.black),
          ),
          IconButton(
            onPressed: () {/*Código para salvar*/},
            icon: Icon(Icons.save, color: AppColors.black),
          ),
        ],
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _controller.dateTextFormFieldController,
              decoration: textFormFieldDecoration1('Data', null, false),
              style: TextStyle(fontWeight: FontWeight.bold),
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _controller.selectDate(context),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              decoration: textFormFieldDecoration1('Nome', null, false),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SPACEFORMS),
            DropdownButtonFormField(
              decoration: textFormFieldDecoration1('Categoria', null, false),
              style: TextStyle(fontWeight: FontWeight.bold),
              items: [],
            ),
            SizedBox(height: SPACEFORMS),
            Obx(() => DropdownButtonFormField<String>(
                  decoration: textFormFieldDecoration1(
                      'Qualidade da despesa', null, false),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 16),
                  value: _controller.selectedExpenseQuality,
                  onChanged: (newValue) {
                    _controller.selectedExpenseQuality(newValue);
                  },
                  items: _controller.expenseQualityList.map((value) {
                    return DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              color: value == 'Não essencial'
                                  ? AppColors.expenseColor
                                  : value == 'Essencial'
                                      ? AppColors.incomeColor
                                      : AppColors.investcolor),
                          Text('  '),
                          Text(value),
                        ],
                      ),
                      //child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  isExpanded: true,
                )),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              decoration: textFormFieldDecoration1('Valor', null, false),
              style: TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: SPACEFORMS),
            DropdownButtonFormField(
              decoration: textFormFieldDecoration1('Parcelamento', null, false),
              style: TextStyle(fontWeight: FontWeight.bold),
              items: [],
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              decoration: textFormFieldDecoration1('Observações', null, true),
              style: TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
