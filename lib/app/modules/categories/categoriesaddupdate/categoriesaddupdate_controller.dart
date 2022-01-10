import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';

class CategoriesAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  TextEditingController? nameTextController, descriptionTextController;

  RxString _categoryType = ''.obs;
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
    super.onInit();
    nameTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    paintContainerType();
  }

  // Muda a cor do container do tipo de categoria
  void paintContainerType() {
    if (categoryType == 'Receita') {
      containerRadioReceitaColor = Colors.green[200];
      containerRadioDespesaColor = null;
    } else if (categoryType == 'Despesa') {
      containerRadioReceitaColor = null;
      containerRadioDespesaColor = Colors.red[100];
    } else {
      containerRadioReceitaColor = null;
      containerRadioDespesaColor = null;
    }
  }

  void saveUpdateCategory({required String addEditFlag}) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (nameTextController!.text != '' && descriptionTextController!.text != '') {
        categoryName = nameTextController!.text;
        _categoriesRepository
            .addCategory(
              userUid: user!.id,
              catName: nameTextController!.text,
              catType: categoryType,
              catDescription: descriptionTextController!.text,
            )
            .whenComplete(
              () => AppSnackbar.snackarStyle(title: categoryName, message: 'Categoria cadastrada com sucesso'),
            );
        clearEditingControllers();
        Get.back();
      }
    } else if (addEditFlag == 'UPDATE') {
      if (nameTextController!.text != '' && descriptionTextController!.text != '') {
        categoryName = nameTextController!.text;
        _categoriesRepository
            .updateCategory(userUid: user!.id, catName: nameTextController!.text, catType: categoryType, catDescription: descriptionTextController!.text, catUid: categoryId)
            .whenComplete(
              () => AppSnackbar.snackarStyle(title: categoryName, message: 'Categoria atualizada com sucesso'),
            );
        clearEditingControllers();
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
    nameTextController!.clear();
    descriptionTextController!.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
