import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/utils/app_functions.dart';
import '../../core/values/app_constants.dart';
import '../../global_widgets/divider_horizontal.dart';
import 'categoriesaddupdate_controller.dart';

class CategoriesAddUpdatePage extends GetView<CategoriesAddUpdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.themeColor,
        title: Text('Categorias'),
        actions: [
          IconButton(
            onPressed: () => controller.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => controller.saveUpdateCategory(
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
            SizedBox(height: SPACEFORMS * 2),
            Obx(
              () => TextFormField(
                controller: controller.nameTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: controller.categoryName,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () {
                  controller.nameTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.nameTextController.text.length),
                  );
                },
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.containerRadioReceitaColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.green[800],
                            value: 'Receita',
                            groupValue: controller.categoryType,
                            onChanged: (value) {
                              controller.categoryType = value as String;
                              controller.paintContainerType();
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Receita',
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
                        color: controller.containerRadioDespesaColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.red[500],
                            value: 'Despesa',
                            groupValue: controller.categoryType,
                            onChanged: (value) {
                              controller.categoryType = value as String;
                              controller.paintContainerType();
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Despesa',
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
            ),
            SizedBox(height: SPACEFORMS),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: controller.descriptionTextController,
              decoration: textFormFieldMultilines('Descrição'),
              validator: (value) => validator(value),
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
