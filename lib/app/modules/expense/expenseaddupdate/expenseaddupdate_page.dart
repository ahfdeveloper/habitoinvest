import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/global/widgets/disable_focusnode/disable_focusnode.dart';
import 'package:habito_invest_app/app/global/widgets/divider_horizontal/divider_horizontal.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_controller.dart';

class ExpenseAddUpdatePage extends StatelessWidget {
  final ExpenseAddUpdateController _expenseAddUpdateController =
      Get.find<ExpenseAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _expenseAddUpdateController.formkey;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.expenseColor,
        automaticallyImplyLeading: false,
        title: Text('Cadastrar Despesa'),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _expenseAddUpdateController.saveUpdateExpense(
              addEditFlag: _expenseAddUpdateController.addEditFlag,
            ),
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
              controller: _expenseAddUpdateController
                  .expenseValueTextFormFieldController,
              validator: (value) => validatorExpenseValue(value),
              style: AppTextStyles.valueExpenseOperationStyle,
              keyboardType: TextInputType.number,
              decoration: textFormFieldValueOperation(),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: _expenseAddUpdateController.pay,
                    onChanged: (newValue) =>
                        _expenseAddUpdateController.pay = newValue as bool,
                  ),
                ),
                Text('Pago'),
              ],
            ),

            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller:
                  _expenseAddUpdateController.dateShopTextFormFieldController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data da despesa',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => _expenseAddUpdateController.selectDateShop(
                  context: context,
                  textFormFieldController: _expenseAddUpdateController
                      .dateShopTextFormFieldController),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => TextFormField(
                controller:
                    _expenseAddUpdateController.descriptionTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: _expenseAddUpdateController.descriptionValue,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () {
                  _expenseAddUpdateController.descriptionValue = '';
                  _expenseAddUpdateController.descriptionTextController!.text =
                      _expenseAddUpdateController.descriptionValue;
                },
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => DropdownButtonFormField(
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
                  '${_expenseAddUpdateController.selectedCategory.toString()}',
                ),
                value: _expenseAddUpdateController.selectedCategory,
                items: _expenseAddUpdateController.selectIncomeCategory().map(
                  (String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  _expenseAddUpdateController.selectedCategory =
                      newValue as String;
                },
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
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
                value: _expenseAddUpdateController.selectedExpenseQuality,
                items: _expenseAddUpdateController.expenseQualityList.map(
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
                  _expenseAddUpdateController.selectedExpenseQuality =
                      newValue as String;
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
                            color: _expenseAddUpdateController
                                .containerRadioSimColor,
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
                                groupValue: _expenseAddUpdateController
                                    .installmentsType,
                                onChanged: (value) {
                                  _expenseAddUpdateController.installmentsType =
                                      value as String;
                                  _expenseAddUpdateController
                                      .paintContainerType();
                                  _expenseAddUpdateController
                                      .visibilityInstallmentsNo = false;
                                  _expenseAddUpdateController
                                      .visibilityInstallmentsYes = true;
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
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _expenseAddUpdateController
                                .containerRadioNaoColor,
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
                                groupValue: _expenseAddUpdateController
                                    .installmentsType,
                                onChanged: (value) {
                                  _expenseAddUpdateController.installmentsType =
                                      value as String;
                                  _expenseAddUpdateController
                                      .paintContainerType();
                                  _expenseAddUpdateController
                                      .visibilityInstallmentsNo = true;
                                  _expenseAddUpdateController
                                      .visibilityInstallmentsYes = false;
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
                    ],
                  ),

                  // Container será visível se o pagamento for parcelado
                  Visibility(
                    visible:
                        _expenseAddUpdateController.visibilityInstallmentsYes,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 15.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _expenseAddUpdateController.containerRadioSimColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: SPACEFORMS),
                          TextFormField(
                              controller: _expenseAddUpdateController
                                  .datePortionTextFormFieldController,
                              focusNode: DisabledFocusNode(),
                              decoration: textFormFieldFormsLabel(
                                fieldIcon: Icons.date_range_outlined,
                                label: 'Data de pagamento da 1ª parcela',
                                hint: null,
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              onTap: () {
                                _expenseAddUpdateController.selectDatePortion(
                                  context: context,
                                  textFormFieldController:
                                      _expenseAddUpdateController
                                          .datePortionTextFormFieldController,
                                );
                              }),
                          Divider(color: AppColors.grey800),
                          TextFormField(
                            controller: _expenseAddUpdateController
                                .dayPayPortionTextController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              labelText: 'Quantidade de parcelas',
                              alignLabelWithHint: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: SPACEFORMS),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              labelText: 'Dia de pagamento das demais parcelas',
                              alignLabelWithHint: true,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Container será visível se o pagamento NÃO for parcelado
                  Visibility(
                    visible:
                        _expenseAddUpdateController.visibilityInstallmentsNo,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: 15.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _expenseAddUpdateController.containerRadioNaoColor,
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
                              Expanded(
                                child: TextFormField(
                                  controller: _expenseAddUpdateController
                                      .dateNoPortionFormFieldController,
                                  focusNode: DisabledFocusNode(),
                                  decoration: textFormFieldFormsLabel(
                                    fieldIcon: Icons.date_range_outlined,
                                    label: 'Data efetiva do pagamento',
                                    hint: null,
                                  ),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.number,
                                  onTap: () {
                                    _expenseAddUpdateController
                                        .selectDatePortion(
                                      context: context,
                                      textFormFieldController:
                                          _expenseAddUpdateController
                                              .dateNoPortionFormFieldController,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(color: AppColors.grey800),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller:
                  _expenseAddUpdateController.addInformationTextController,
              decoration:
                  textFormFieldMultilines('Informações adicionais (opcional)'),
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

  validatorExpenseValue(value) {
    if (value == 'R\$ 0,00') {
      return 'Valor deve ser diferente de zero';
    }
    return null;
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
    if (value == _expenseAddUpdateController.firstElementDrop) {
      return 'Selecione um item';
    }
    return null;
  }
}
