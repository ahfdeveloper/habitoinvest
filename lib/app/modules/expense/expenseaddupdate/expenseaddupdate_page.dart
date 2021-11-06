import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
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
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _expenseAddUpdateController
                  .dateRegisterTextFormFieldController,
              decoration: textFormFieldDecoration1('Data', null, false),
              style: TextStyle(fontWeight: FontWeight.bold),
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _expenseAddUpdateController.selectDate(
                  context: context,
                  textFormFieldController: _expenseAddUpdateController
                      .dateRegisterTextFormFieldController),
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
                    color: AppColors.themeColor,
                    fontSize: 16,
                  ),
                  value: _expenseAddUpdateController.selectedExpenseQuality,
                  onChanged: (newValue) => _expenseAddUpdateController
                      .selectedExpenseQuality(newValue),
                  items: _expenseAddUpdateController.expenseQualityList
                      .map((value) {
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
                          Text('  '),
                          Text(value),
                        ],
                      ),
                      value: value,
                    );
                  }).toList(),
                  isExpanded: true,
                )),
            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            Text(
              'Parcelado?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: AppColors.grey,
              ),
            ),
            Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                                    fontSize: 17.0,
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
                                    fontSize: 17.0,
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
                          TextFormField(
                            decoration: textFormFieldDecoration1(
                              'Quantidade de parcelas',
                              null,
                              false,
                            ),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            decoration: textFormFieldDecoration1(
                                'Valor da parcela ', null, false),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            controller: _expenseAddUpdateController
                                .dateInstallmentsTextFormFieldController,
                            focusNode: AlwaysDisabledFocusNode(),
                            decoration: textFormFieldDecoration1(
                                'Data de pagamento da 1ª parcela', null, false),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            onTap: () => _expenseAddUpdateController.selectDate(
                                context: context,
                                textFormFieldController:
                                    _expenseAddUpdateController
                                        .dateInstallmentsTextFormFieldController),
                          ),
                          TextFormField(
                            decoration: textFormFieldDecoration1(
                                'Dia de pagamento das demais parcelas',
                                null,
                                false),
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: textFormFieldDecoration1(
                                'Valor',
                                null,
                                false,
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: SPACEFORMS),
                          Expanded(
                            child: TextFormField(
                                controller: _expenseAddUpdateController
                                    .dateNoInstallmentsFormFieldController,
                                focusNode: AlwaysDisabledFocusNode(),
                                decoration: textFormFieldDecoration1(
                                  'Data do pagamento',
                                  null,
                                  false,
                                ),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                                onTap: () => _expenseAddUpdateController.selectDate(
                                    context: context,
                                    textFormFieldController:
                                        _expenseAddUpdateController
                                            .dateNoInstallmentsFormFieldController)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
