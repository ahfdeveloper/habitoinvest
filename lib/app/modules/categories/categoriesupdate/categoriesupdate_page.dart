import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';

import 'categoriesupdate_controller.dart';

class CategoriesUpdatePage extends StatelessWidget {
  final CategoriesUpdateController _categoriesUpdateController =
      CategoriesUpdateController();

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    var formkey = GlobalKey<FormState>();

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
              //_categoriesAddUpdateController.updateCategory();
              Get.back();
            },
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _categoriesUpdateController.nameTextController,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              controller: _categoriesUpdateController.descriptionTextController,
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
