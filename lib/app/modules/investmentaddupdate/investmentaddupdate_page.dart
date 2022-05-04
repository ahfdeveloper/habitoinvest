import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/values/app_constants.dart';
import '../../global_widgets/divider_horizontal.dart';
import 'investmentaddupdate_controller.dart';

class InvestAddUpdatePage extends GetView<InvestmentAddUpdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.investColor,
        title: Text(controller.title, style: TextStyle(fontSize: 17.0)),
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            onPressed: () => controller.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => controller.saveUpdateInvestment(
              addEditFlag: controller.addEditFlag,
            ),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Form(
        key: controller.formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: controller.investmentValueTextFormController,
              autofocus: verifyAddUpdate(controller.addEditFlag),
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
                    value: controller.updateEffective,
                    onChanged: (newValue) => controller.updateEffective = newValue!,
                  ),
                ),
                Text('Efetivado'),
              ],
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            TextFormField(
              controller: controller.dateTextController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data do investimento',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => controller.selectDate(context),
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
                onTap: () => controller.descriptionTextController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.descriptionTextController!.text.length),
                ),
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS * 2),
            TextFormField(
              controller: controller.addInformationTextController,
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
