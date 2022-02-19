import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration/decoration.dart';
import 'package:habito_invest_app/app/global/widgets/divider_horizontal/divider_horizontal.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_controller.dart';

class InvestAddUpdatePage extends StatelessWidget {
  final InvestmentAddUpdateController _investmentAddUpdateController = Get.find<InvestmentAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _investmentAddUpdateController.formkey;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.investcolor,
        title: Text('Novo Investimento', style: TextStyle(fontSize: 17.0)),
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            onPressed: () => _investmentAddUpdateController.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _investmentAddUpdateController.saveUpdateInvestment(
              addEditFlag: _investmentAddUpdateController.addEditFlag,
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
              controller: _investmentAddUpdateController.investmentValueTextFormController,
              autofocus: true,
              validator: (value) => validatorValue(value),
              style: AppTextStyles.valueInvestmentOperationStyle,
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
                    value: _investmentAddUpdateController.updateEffective,
                    onChanged: (newValue) => _investmentAddUpdateController.updateEffective = newValue!,
                  ),
                ),
                Text('Efetivado'),
              ],
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            TextFormField(
              controller: _investmentAddUpdateController.dateTextController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data do investimento',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => _investmentAddUpdateController.selectDate(context),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => TextFormField(
                controller: _investmentAddUpdateController.descriptionTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: _investmentAddUpdateController.descriptionValue,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () {
                  _investmentAddUpdateController.descriptionValue = '';
                  _investmentAddUpdateController.descriptionTextController!.text = _investmentAddUpdateController.descriptionValue;
                },
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS * 2),
            TextFormField(
              controller: _investmentAddUpdateController.addInformationTextController,
              decoration: textFormFieldMultilines('Informações adicionais (opcional)'),
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
