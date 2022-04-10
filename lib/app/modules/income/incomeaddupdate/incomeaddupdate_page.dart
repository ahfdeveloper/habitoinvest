import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import '../../../core/theme/app_decoration.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/values/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../global_widgets/divider_horizontal.dart';

class IncomeAddUpdatePage extends StatelessWidget {
  final IncomeAddUpdateController _incomeAddUpdateController = Get.find<IncomeAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _incomeAddUpdateController.formkey;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.incomeColor,
        title: Text('Receita'),
        actions: [
          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              _incomeAddUpdateController.cancel();
              _incomeAddUpdateController.clearEditingControllers();
            },
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _incomeAddUpdateController.saveUpdateIncome(addEditFlag: _incomeAddUpdateController.addEditFlag),
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
              controller: _incomeAddUpdateController.incomeValueTextFormController,
              autofocus: true,
              validator: (value) => validatorValue(value),
              style: AppTextStyles.valueIncomeOperationStyle,
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
                    value: _incomeAddUpdateController.updateReceived,
                    onChanged: (newValue) => _incomeAddUpdateController.updateReceived = newValue!,
                  ),
                ),
                Text('Recebido'),
              ],
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            TextFormField(
              controller: _incomeAddUpdateController.dateTextController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldForms(
                fieldIcon: Icons.date_range_outlined,
                label: 'Data da receita',
                hint: null,
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
              onTap: () => _incomeAddUpdateController.selectDate(context),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            //
            Obx(
              () => TextFormField(
                controller: _incomeAddUpdateController.descriptionTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: _incomeAddUpdateController.descriptionValue,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () => _incomeAddUpdateController.descriptionTextController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: _incomeAddUpdateController.descriptionTextController!.text.length),
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
                      () => DropdownButtonFormField(
                        validator: (value) => validatorDropdown(value),
                        decoration: textFormFieldForms(fieldIcon: Icons.category_outlined, hint: ''),
                        elevation: 16,
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.themeColor, fontSize: 16),
                        hint: Text('${_incomeAddUpdateController.selectedCategory.toString()}'),
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
                          _incomeAddUpdateController.selectedCategory = newValue as String;
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
                      onPressed: () => Get.toNamed(Routes.CATEGORIES_ADDUPDATE, arguments: _incomeAddUpdateController.user),
                    ),
                  ),
                )
              ],
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS * 2),
            //
            TextFormField(
              controller: _incomeAddUpdateController.addInformationTextController,
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

  // Função de validação do Dropdownbutton
  validatorDropdown(value) {
    if (value == _incomeAddUpdateController.firstElementDrop) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
