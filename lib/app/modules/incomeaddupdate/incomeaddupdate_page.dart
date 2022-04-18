import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/values/app_constants.dart';
import '../../global_widgets/app_addcategory_button.dart';
import '../../global_widgets/divider_horizontal.dart';
import '../../routes/routes.dart';
import 'incomeaddupdate_controller.dart';

class IncomeAddUpdatePage extends GetView<IncomeAddUpdateController> {
  @override
  Widget build(BuildContext context) {
    final _formkey = controller.formkey;

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
              controller.cancel();
              controller.clearEditingControllers();
            },
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => controller.saveUpdateIncome(addEditFlag: controller.addEditFlag),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Obx(
        () => controller.categoriesList.isEmpty || controller.categoriesList == []
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formkey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 13.0),
                  children: [
                    SizedBox(height: SPACEFORMS),
                    TextFormField(
                      controller: controller.incomeValueTextFormController,
                      autofocus: verifyAddUpdate(controller.addEditFlag),
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
                            value: controller.updateReceived,
                            onChanged: (newValue) => controller.updateReceived = newValue!,
                          ),
                        ),
                        Text('Recebido'),
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
                        label: 'Data da receita',
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
                        onTap: () => controller.descriptionTextController.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.descriptionTextController.text.length),
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
                                hint: Text('${controller.selectedCategory.toString()}'),
                                value: controller.selectedCategory,
                                items: controller.selectIncomeCategory().map(
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
                        ),
                        AddCategoryButton(userData: controller.user!),
                      ],
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
                    SizedBox(height: SPACEFORMS),
                  ],
                ),
              ),
      ),
    );
  }

  // Função de validação do Dropdownbutton
  validatorDropdown(value) {
    if (value == controller.firstElementDrop) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
