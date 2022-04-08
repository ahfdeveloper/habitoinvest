import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/functions.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_controller.dart';
import '../../../global/constants.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/decoration.dart';
import '../../../widgets/divider_horizontal.dart';

class CategoriesAddUpdatePage extends StatelessWidget {
  final CategoriesAddUpdateController _categoriesAddUpdateController = Get.find<CategoriesAddUpdateController>();

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
            onPressed: () => _categoriesAddUpdateController.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _categoriesAddUpdateController.saveUpdateCategory(
              addEditFlag: _categoriesAddUpdateController.addEditFlag,
            ),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Form(
        key: _categoriesAddUpdateController.formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          children: [
            SizedBox(height: SPACEFORMS * 2),
            Obx(
              () => TextFormField(
                controller: _categoriesAddUpdateController.nameTextController,
                validator: (value) => validator(value),
                decoration: textFormFieldForms(
                  fieldIcon: Icons.description_outlined,
                  hint: _categoriesAddUpdateController.categoryName,
                ),
                style: TextStyle(fontWeight: FontWeight.bold),
                onTap: () {
                  _categoriesAddUpdateController.categoryName = '';
                  _categoriesAddUpdateController.nameTextController!.text = _categoriesAddUpdateController.categoryName;
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
                        color: _categoriesAddUpdateController.containerRadioReceitaColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.green[800],
                            value: 'Receita',
                            groupValue: _categoriesAddUpdateController.categoryType,
                            onChanged: (value) {
                              _categoriesAddUpdateController.categoryType = value as String;
                              _categoriesAddUpdateController.paintContainerType();
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
                        color: _categoriesAddUpdateController.containerRadioDespesaColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.red[500],
                            value: 'Despesa',
                            groupValue: _categoriesAddUpdateController.categoryType,
                            onChanged: (value) {
                              _categoriesAddUpdateController.categoryType = value as String;
                              _categoriesAddUpdateController.paintContainerType();
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
              controller: _categoriesAddUpdateController.descriptionTextController,
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
