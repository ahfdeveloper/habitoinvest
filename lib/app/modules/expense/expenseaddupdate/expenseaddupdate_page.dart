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
            onPressed: () {/*Código para salvar*/},
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      //
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _expenseAddUpdateController
                  .expenseValueTextFormFieldController,
              style: AppTextStyles.valueOperationStyle,
              keyboardType: TextInputType.number,
              decoration: textFormFieldValueOperation(),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _expenseAddUpdateController
                  .dateRegisterTextFormFieldController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data da despesa',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => _expenseAddUpdateController.selectDate(
                context: context,
                textFormFieldController: _expenseAddUpdateController
                    .dateRegisterTextFormFieldController,
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            TextFormField(
              initialValue: 'Descrição',
              decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  label: 'Descrição',
                  hint: null),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            DropdownButtonFormField(
              decoration: textFormFieldForms(
                  fieldIcon: Icons.category_outlined,
                  label: 'Categoria',
                  hint: ''),
              style: TextStyle(fontWeight: FontWeight.bold),
              items: [],
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
                onChanged: (newValue) => _expenseAddUpdateController
                    .selectedExpenseQuality(newValue),
                items:
                    _expenseAddUpdateController.expenseQualityList.map((value) {
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
                }).toList(),
                isExpanded: true,
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            //
            // Text(
            //   'Parcelado?',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 17,
            //     color: AppColors.grey,
            //   ),
            // ),
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
                                  .dateInstallmentsTextFormFieldController,
                              focusNode: DisabledFocusNode(),
                              decoration: textFormFieldFormsLabel(
                                fieldIcon: Icons.date_range_outlined,
                                label: 'Data de pagamento da 1ª parcela',
                                hint: null,
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              onTap: () {
                                _expenseAddUpdateController.selectDate(
                                  context: context,
                                  textFormFieldController:
                                      _expenseAddUpdateController
                                          .dateInstallmentsTextFormFieldController,
                                );
                              }),
                          Divider(color: AppColors.grey800),
                          TextFormField(
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
                                      .dateNoInstallmentsFormFieldController,
                                  focusNode: DisabledFocusNode(),
                                  decoration: textFormFieldFormsLabel(
                                    fieldIcon: Icons.date_range_outlined,
                                    label: 'Data efetiva do pagamento',
                                    hint: null,
                                  ),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.number,
                                  onTap: () {
                                    _expenseAddUpdateController.selectDate(
                                      context: context,
                                      textFormFieldController:
                                          _expenseAddUpdateController
                                              .dateNoInstallmentsFormFieldController,
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
}
