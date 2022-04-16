import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/values/app_constants.dart';
import '../../global_widgets/divider_horizontal.dart';
import '../../routes/routes.dart';
import 'expenseadd_controller.dart';

class ExpenseAddPage extends StatelessWidget {
  final ExpenseAddController _expenseAddController = Get.find<ExpenseAddController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _expenseAddController.formkey;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.expenseColor,
        automaticallyImplyLeading: false,
        title: Text('Cadastrar Despesa'),
        actions: [
          IconButton(
            onPressed: () => _expenseAddController.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _expenseAddController.saveExpense(),
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
              controller: _expenseAddController.expenseValueTextFormFieldController,
              autofocus: true,
              validator: (value) => validatorValue(value),
              style: AppTextStyles.valueExpenseOperationStyle,
              keyboardType: TextInputType.number,
              decoration: textFormFieldValueOperation(),
              onChanged: (value) {
                _expenseAddController.workedCost(value);
              },
            ),
            DividerHorizontal(),
            SizedBox(height: 3.0),
            Obx(
              () => Row(
                children: [
                  Text('Horas de trabalho: '),
                  Text(
                    _expenseAddController.workedHours.toStringAsFixed(1) + ' *',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.0),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              controller: _expenseAddController.dateExpenseTextFormFieldController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data da despesa',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => _expenseAddController.selectDate(context: context, textFormFieldController: _expenseAddController.dateExpenseTextFormFieldController),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => TextFormField(
                controller: _expenseAddController.descriptionTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: _expenseAddController.descriptionValue,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () => _expenseAddController.descriptionTextController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: _expenseAddController.descriptionTextController!.text.length),
                ),
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Obx(
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
                          '${_expenseAddController.selectedCategory.toString()}',
                        ),
                        value: _expenseAddController.selectedCategory,
                        items: _expenseAddController.selectExpenseCategory().map(
                          (String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          },
                        ).toList(),
                        onChanged: (newValue) {
                          _expenseAddController.selectedCategory = newValue as String;
                        },
                        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.add_box_outlined),
                      color: AppColors.themeColor,
                      onPressed: () => Get.toNamed(Routes.CATEGORIES_ADDUPDATE, arguments: _expenseAddController.user),
                    ),
                  ),
                ),
              ],
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
                value: _expenseAddController.selectedExpenseQuality,
                items: _expenseAddController.expenseQualityList.map(
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
                  _expenseAddController.selectedExpenseQuality = newValue as String;
                },
                isExpanded: true,
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          'Parcelado?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _expenseAddController.containerRadioNaoColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                activeColor: AppColors.themeColor,
                                value: 'Não',
                                groupValue: _expenseAddController.installmentsType,
                                onChanged: (value) {
                                  _expenseAddController.installmentsType = value as String;
                                  _expenseAddController.paintContainerType();
                                  _expenseAddController.visibilityInstallmentsNo = true;
                                  _expenseAddController.visibilityInstallmentsYes = false;
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Não',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _expenseAddController.containerRadioSimColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                activeColor: AppColors.themeColor,
                                value: 'Sim',
                                groupValue: _expenseAddController.installmentsType,
                                onChanged: (value) {
                                  _expenseAddController.installmentsType = value as String;
                                  _expenseAddController.paintContainerType();
                                  _expenseAddController.visibilityInstallmentsNo = false;
                                  _expenseAddController.visibilityInstallmentsYes = true;
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Sim',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Container será visível se o pagamento NÃO for parcelado
                  Visibility(
                    visible: _expenseAddController.visibilityInstallmentsNo,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 15.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: _expenseAddController.containerRadioNaoColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: SPACEFORMS),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: _expenseAddController.pay,
                                      onChanged: (newValue) => _expenseAddController.pay = newValue as bool,
                                    ),
                                  ),
                                  Text('Pago'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Container será visível se o pagamento for parcelado
                  Visibility(
                    visible: _expenseAddController.visibilityInstallmentsYes,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 15.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: _expenseAddController.containerRadioSimColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: SPACEFORMS),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: _expenseAddController.pay,
                                  onChanged: (newValue) => _expenseAddController.pay = newValue as bool,
                                ),
                              ),
                              Text('Pago'),
                            ],
                          ),
                          TextFormField(
                            controller: _expenseAddController.qtPortionTextController,
                            validator: (value) => validatorQtPortion(int.parse(value!)),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              labelText: 'Quantidade de parcelas mensais',
                              alignLabelWithHint: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: SPACEFORMS),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _expenseAddController.addInformationTextController,
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
    );
  }

  // Função de validação da quantidade de parcelas
  validatorQtPortion(value) {
    if (value < 2) {
      return 'Quantidade de parcelas deve ser maior que 1';
    }
  }

  // Função de validação do Dropdownbutton
  validatorDropdown(value) {
    if (value == _expenseAddController.firstElementDrop) {
      return 'Selecione um item';
    }
    return null;
  }
}