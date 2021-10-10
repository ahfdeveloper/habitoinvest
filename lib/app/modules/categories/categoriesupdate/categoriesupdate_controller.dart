import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';

class CategoriesUpdateController extends GetxController {
  //CategoriesRepository _categoriesRepository = CategoriesRepository();
  final UserModel user = Get.arguments;
  late TextEditingController nameTextController,
      descriptionTextController = TextEditingController();

  @override
  void onInit() {
    nameTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    super.onInit();
  }

  /* updateCategory() {
    if (nameTextController.text != '' && descriptionTextController.text != '') {
      _categoriesRepository.updateCategory(
          user!.id, nameTextController.text, descriptionTextController.text);
      nameTextController.clear();
      descriptionTextController.clear();
    }
  } */
}
