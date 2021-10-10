import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_controller.dart';

class CategoriesAddUpdatePage extends StatelessWidget {
  final CategoriesAddUpdateController _categoriesAddUpdateController =
      CategoriesAddUpdateController();

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    var _formkey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: interfaceColor,
        title: Text('Categorias'),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                _categoriesAddUpdateController.saveCategory();
              }
            },
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
              controller: _categoriesAddUpdateController.nameTextController,
              validator: (value) => validator(value),
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 5.0),
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
