import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/categories_repository.dart';

class CategoriesAddUpdateController extends GetxController {
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final UserModel? user = Get.arguments;
  late TextEditingController nameTextController = TextEditingController();
  late TextEditingController descriptionTextController =
      TextEditingController();

  void onInit() {
    nameTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    super.onInit();
  }

  saveCategory() {
    if (nameTextController.text != '' && descriptionTextController.text != '') {
      _categoriesRepository.addCategory(
          userUid: user!.id,
          catName: nameTextController.text,
          catDescription: descriptionTextController.text);
      nameTextController.clear();
      descriptionTextController.clear();
    }
  }
}
