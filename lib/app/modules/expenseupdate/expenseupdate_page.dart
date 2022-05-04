import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/values/app_constants.dart';
import '../../global_widgets/app_addcategory_button.dart';
import '../../global_widgets/divider_horizontal.dart';
import 'expenseupdate_controller.dart';

class ExpenseUpdatePage extends GetView<ExpenseUpdateController> {
  @override
  Widget build(BuildContext context) {
    final _formkey = controller.formkey;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.expenseColor,
        automaticallyImplyLeading: false,
        title: Text('Atualizar Despesa'),
        actions: [
          IconButton(
            onPressed: () => cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => controller.updateExpense(),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      //
      body: Obx(
        () => controller.parametersList.isEmpty || controller.parametersList == [] || controller.categoriesList.isEmpty || controller.categoriesList == []
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formkey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  children: [
                    SizedBox(height: SPACEFORMS),
                    TextFormField(
                      controller: controller.expenseValueTextFormController,
                      autofocus: false,
                      validator: (value) => validatorExpenseValue(value),
                      style: AppTextStyles.valueExpenseOperationStyle,
                      keyboardType: TextInputType.number,
                      decoration: textFormFieldValueOperation(),
                      onChanged: (value) {
                        controller.workedCost(value);
                      },
                    ),
                    DividerHorizontal(),
                    SizedBox(height: 3.0),
                    Obx(
                      () => Row(
                        children: [
                          Text('Horas de trabalho: '),
                          Text(
                            controller.workedHours.toStringAsFixed(1) + ' *',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.0),
                    DividerHorizontal(),
                    SizedBox(height: SPACEFORMS),
                    //
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.updatePay,
                            onChanged: (newValue) => controller.updatePay = newValue as bool,
                          ),
                        ),
                        Text('Pago'),
                      ],
                    ),
                    DividerHorizontal(),
                    SizedBox(height: SPACEFORMS),

                    TextFormField(
                      controller: controller.dateUpdateTextController,
                      focusNode: DisabledFocusNode(),
                      decoration: textFormFieldForms(
                        fieldIcon: Icons.date_range_outlined,
                        label: 'Data da despesa',
                        hint: null,
                      ),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      onTap: () => controller.selectDate(context: context, textFormFieldController: controller.dateUpdateTextController),
                    ),
                    DividerHorizontal(),
                    SizedBox(height: SPACEFORMS),
                    //
                    Obx(
                      () => TextFormField(
                        controller: controller.descriptionTextController,
                        validator: (value) => validator(value),
                        decoration: textFormFieldForms(
                          fieldIcon: Icons.description_outlined,
                          hint: controller.descriptionValue,
                        ),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        onTap: () => controller.descriptionTextController.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.descriptionTextController.text.length),
                        ),
                      ),
                    ),
                    DividerHorizontal(),
                    SizedBox(height: SPACEFORMS),

                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Obx(
                            () => DropdownButtonFormField(
                              validator: (value) => validatorDropdown(value),
                              decoration: textFormFieldForms(fieldIcon: Icons.category_outlined, hint: ''),
                              elevation: 16,
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.themeColor, fontSize: 16),
                              hint: Text(
                                '${controller.selectedCategory.toString()}',
                              ),
                              value: controller.selectedCategory,
                              items: controller.selectExpenseCategory().map(
                                (String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                },
                              ).toList(),
                              onChanged: (newValue) {
                                controller.selectedCategory = newValue as String;
                              },
                              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                            ),
                          ),
                        ),
                        AddCategoryButton(userData: controller.user!),
                      ],
                    ),

                    DividerHorizontal(),
                    SizedBox(height: SPACEFORMS),

                    Obx(
                      () => DropdownButtonFormField<String>(
                        decoration: InputDecoration(contentPadding: EdgeInsets.zero, border: InputBorder.none),
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.themeColor, fontSize: 16),
                        value: controller.selectedExpenseQuality,
                        items: controller.expenseQualityList.map(
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
                                            : AppColors.investColor,
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
                          controller.selectedExpenseQuality = newValue as String;
                        },
                        isExpanded: true,
                      ),
                    ),

                    SizedBox(height: SPACEFORMS * 2),
                    TextFormField(
                      controller: controller.addInformationTextController,
                      decoration: textFormFieldMultilines('Informações adicionais (opcional)'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                    SizedBox(height: SPACEFORMS * 2),
                    Text(
                      '*O cálculo das horas de trabalho que equivalem ao valor da despesa é calculado com base nas médias ' +
                          'de renda mensal e horas trabalhadas por semana definidas nos parâmetros.',
                    )
                  ],
                ),
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
    if (value == controller.firstElementDrop) {
      return 'Selecione um item';
    }
    return null;
  }
}
