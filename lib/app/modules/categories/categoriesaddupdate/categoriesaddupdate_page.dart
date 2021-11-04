import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_controller.dart';

class CategoriesAddUpdatePage extends StatelessWidget {
  final CategoriesAddUpdateController _categoriesAddUpdateController =
      Get.find<CategoriesAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    final _formkey = _categoriesAddUpdateController.formkey;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: interfaceColor,
        title: Text('Categorias'),
        actions: [
          IconButton(
              onPressed: () => _categoriesAddUpdateController.cancel(),
              icon: Icon(Icons.cancel, color: AppColors.white)),
          IconButton(
            onPressed: () => _categoriesAddUpdateController.saveUpdateCategory(
              addEditFlag: _categoriesAddUpdateController.addEditFlag,
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
            TextFormField(
              controller: _categoriesAddUpdateController.nameTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 20.0),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _categoriesAddUpdateController
                            .containerRadioReceitaColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.green[800],
                            value: 'Receita',
                            groupValue:
                                _categoriesAddUpdateController.categoryType,
                            onChanged: (value) {
                              _categoriesAddUpdateController.categoryType =
                                  value as String;
                              _categoriesAddUpdateController
                                  .paintContainerType();
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
                        color: _categoriesAddUpdateController
                            .containerRadioDespesaColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Colors.red[500],
                            value: 'Despesa',
                            groupValue:
                                _categoriesAddUpdateController.categoryType,
                            onChanged: (value) {
                              _categoriesAddUpdateController.categoryType =
                                  value as String;
                              _categoriesAddUpdateController
                                  .paintContainerType();
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
            TextFormField(
              controller:
                  _categoriesAddUpdateController.descriptionTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Descrição',
                alignLabelWithHint: true,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}

validator(value) {
  if (value!.isEmpty) {
    return 'Campo obrigatório';
  }
  return null;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
