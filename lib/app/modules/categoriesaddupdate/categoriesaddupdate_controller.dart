import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/user_model.dart';
import '../../data/service/category_repository.dart';
import '../../global_widgets/app_snackbar.dart';

class CategoriesAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();

  TextEditingController nameTextController = TextEditingController(text: '');
  TextEditingController descriptionTextController = TextEditingController(text: '');

  RxString _categoryType = 'Receita'.obs;
  String get categoryType => this._categoryType.value;
  set categoryType(String value) {
    _categoryType.update((val) {
      _categoryType.value = value;
    });
  }

  String _categoryId = '';
  String get categoryId => this._categoryId;
  set categoryId(String value) => this._categoryId = value;

  RxString _categoryName = 'Nome'.obs;
  String get categoryName => this._categoryName.value;
  set categoryName(String value) => this._categoryName.value = value;

  String _addEditFlag = '';
  String get addEditFlag => this._addEditFlag;
  set addEditFlag(String value) => this._addEditFlag = value;

  Color? _containerRadioReceitaColor;
  Color? get containerRadioReceitaColor => this._containerRadioReceitaColor;
  set containerRadioReceitaColor(Color? value) => this._containerRadioReceitaColor = value;

  Color? _containerRadioDespesaColor;
  Color? get containerRadioDespesaColor => this._containerRadioDespesaColor;
  set containerRadioDespesaColor(Color? value) => this._containerRadioDespesaColor = value;

  void onInit() {
    addEditFlag = Get.arguments['addEditFlag'];
    if (addEditFlag == 'UPDATE') {
      categoryId = Get.arguments['categoryId'];
      nameTextController = Get.arguments['nameTextController'];
      categoryType = Get.arguments['categoryType'];
      descriptionTextController = Get.arguments['descriptionTextController'];
    }
    paintContainerType();
    super.onInit();
  }

  // Muda a cor do container do tipo de categoria
  void paintContainerType() {
    if (categoryType == 'Receita') {
      containerRadioReceitaColor = Colors.green[200];
      containerRadioDespesaColor = null;
    } else if (categoryType == 'Despesa') {
      containerRadioReceitaColor = null;
      containerRadioDespesaColor = Colors.red[100];
    }
  }

  void saveUpdateCategory({required String addEditFlag}) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (nameTextController.text != '' && descriptionTextController.text != '') {
        categoryName = nameTextController.text;
        _categoriesRepository.addCategory(
          userUid: user!.id,
          catName: nameTextController.text,
          catType: categoryType,
          catDescription: descriptionTextController.text,
        )..whenComplete(() {
            AppSnackbar.snackarStyle(title: categoryName, message: 'Categoria cadastrada com sucesso');
            clearEditingControllers();
          });
        Get.back();
      }
    } else if (addEditFlag == 'UPDATE') {
      if (nameTextController.text != '' && descriptionTextController.text != '') {
        categoryName = nameTextController.text;
        _categoriesRepository.updateCategory(
            userUid: user!.id, catName: nameTextController.text, catType: categoryType, catDescription: descriptionTextController.text, catUid: categoryId)
          ..whenComplete(() {
            FocusManager.instance.primaryFocus?.unfocus();
            AppSnackbar.snackarStyle(title: categoryName, message: 'Categoria atualizada com sucesso');
            clearEditingControllers();
          });
        Get.back();
      }
    }
  }

  // Cancela o cadastro ou edição de uma nova categoria
  void cancel() {
    clearEditingControllers();
    Get.back();
  }

  void clearEditingControllers() {
    nameTextController.clear();
    descriptionTextController.clear();
    addEditFlag = 'NEW';
    categoryType = '';
    paintContainerType();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
