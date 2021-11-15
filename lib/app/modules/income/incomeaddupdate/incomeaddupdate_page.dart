import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';

class IncomeAddUpdatePage extends StatelessWidget {
  final IncomeAddUpdateController _incomeAddUpdateController =
      Get.find<IncomeAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _incomeAddUpdateController.formkey;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.incomeColor,
        title: Text('Nova Receita'),
        actions: [
          IconButton(
            onPressed: () => _incomeAddUpdateController.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _incomeAddUpdateController.saveUpdateIncome(
              addEditFlag: _incomeAddUpdateController.addEditFlag,
            ),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _incomeAddUpdateController.dateTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                  fieldIcon: null, label: 'Data', hint: null),
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _incomeAddUpdateController.selectDate(context),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _incomeAddUpdateController.nameTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                  fieldIcon: null, label: 'Nome', hint: null),
            ),
            SizedBox(height: SPACEFORMS),
            Obx(
              () => DropdownButtonFormField(
                validator: (value) => validatorDropdown(value),
                elevation: 16,
                hint: Text(
                  '${_incomeAddUpdateController.selectedCategory.toString()}',
                ),
                value: _incomeAddUpdateController.selectedCategory,
                items: _incomeAddUpdateController.selectIncomeCategory().map(
                  (String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  _incomeAddUpdateController.selectedCategory =
                      newValue as String;
                },
              ),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _incomeAddUpdateController.valueTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                fieldIcon: null,
                label: 'Valor',
                hint: null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _incomeAddUpdateController.observationTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                fieldIcon: null,
                label: 'Observações',
                hint: null,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  // Função de validação dos TextFormfields
  validator(value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  // Função de validação do Dropdownbutton
  validatorDropdown(value) {
    if (value == _incomeAddUpdateController.firstElementDrop) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
