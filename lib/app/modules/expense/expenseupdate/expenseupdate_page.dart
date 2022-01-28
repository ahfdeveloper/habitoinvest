import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration/decoration.dart';
import 'package:habito_invest_app/app/global/widgets/divider_horizontal/divider_horizontal.dart';
import 'expenseupdate_controller.dart';

class ExpenseUpdatePage extends StatelessWidget {
  final ExpenseUpdateController _expenseUpdateController = Get.find<ExpenseUpdateController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _expenseUpdateController.formkey;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.expenseColor,
        automaticallyImplyLeading: false,
        title: Text('Atualizar Despesa'),
        actions: [
          IconButton(
            onPressed: () => _expenseUpdateController.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _expenseUpdateController.updateExpense(),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      //
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _expenseUpdateController.expenseValueTextFormController,
              validator: (value) => validatorExpenseValue(value),
              style: AppTextStyles.valueExpenseOperationStyle,
              keyboardType: TextInputType.number,
              decoration: textFormFieldValueOperation(),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: _expenseUpdateController.updatePay,
                    onChanged: (newValue) => _expenseUpdateController.updatePay = newValue as bool,
                  ),
                ),
                Text('Pago'),
              ],
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              controller: _expenseUpdateController.dateTextController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data da despesa',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => _expenseUpdateController.selectDate(context: context, textFormFieldController: _expenseUpdateController.dateTextController),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => TextFormField(
                controller: _expenseUpdateController.descriptionTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: _expenseUpdateController.descriptionValue,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () => _expenseUpdateController.descriptionTextController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: _expenseUpdateController.descriptionTextController!.text.length),
                ),
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),

            Obx(
              () => DropdownButtonFormField<String>(
                validator: (value) => validatorDropdown(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.category_outlined,
                  hint: '',
                ),
                elevation: 16,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor,
                  fontSize: 16,
                ),
                hint: Text(
                  '${_expenseUpdateController.selectedCategory.toString()}',
                ),
                value: _expenseUpdateController.selectedCategory,
                items: _expenseUpdateController.selectExpenseCategory().map(
                  (String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  _expenseUpdateController.selectedCategory = newValue as String;
                },
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),

            Obx(
              () => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor,
                  fontSize: 16,
                ),
                value: _expenseUpdateController.selectedExpenseQuality,
                items: _expenseUpdateController.expenseQualityList.map(
                  (value) {
                    return DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: value == 'Não essencial'
                                ? AppColors.expenseColor
                                : value == 'Essencial'
                                    ? AppColors.incomeColor
                                    : AppColors.investcolor,
                          ),
                          Text('    '),
                          Text(value),
                        ],
                      ),
                      value: value,
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  _expenseUpdateController.selectedExpenseQuality = newValue as String;
                },
                isExpanded: true,
              ),
            ),

            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _expenseUpdateController.addInformationTextController,
              decoration: textFormFieldMultilines('Informações adicionais (opcional)'),
              style: TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            SizedBox(height: SPACEFORMS),
          ],
        ),
      ),
    );
  }

  // Validação do TextFormField de valor da despesa
  validatorExpenseValue(value) {
    if (value == 'R\$ 0,00') {
      return 'Valor deve ser diferente de zero';
    }
    return null;
  }

  // Função de validação da quantidade de parcelas
  validatorQtPortion(value) {
    if (value < 2) {
      return 'Quantidade de parcelas deve ser maior que 1';
    }
  }

  // Função de validação do Dropdownbutton
  validatorDropdown(value) {
    if (value == _expenseUpdateController.firstElementDrop) {
      return 'Selecione um item';
    }
    return null;
  }
}
