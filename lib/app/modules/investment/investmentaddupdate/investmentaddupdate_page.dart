import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_controller.dart';
import '../../../core/theme/app_decoration.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/values/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../global_widgets/divider_horizontal.dart';

class InvestAddUpdatePage extends StatelessWidget {
  final _investmentAddUpdateController = Get.put(InvestmentAddUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.investColor,
        title: Text(_investmentAddUpdateController.title, style: TextStyle(fontSize: 17.0)),
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
        key: _investmentAddUpdateController.formkey,
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
                onTap: () => _investmentAddUpdateController.descriptionTextController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: _investmentAddUpdateController.descriptionTextController!.text.length),
                ),
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
