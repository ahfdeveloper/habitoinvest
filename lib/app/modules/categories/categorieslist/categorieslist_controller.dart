import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/categories_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';

class CategoriesListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoriesRepository _categoriesRepository = CategoriesRepository();

  String _categoryId = '';
  String get categoryId => this._categoryId;
  set categoryId(String value) => this._categoryId = value;

  String _categoryName = '';
  String get categoryName => this._categoryName;
  set categoryName(String value) => this._categoryName = value;

  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categories => _categoriesList.value;

  @override
  void onInit() {
    _categoriesList.bindStream(
      _categoriesRepository.getAllCategories(userUid: user!.id),
    );
    super.onInit();
  }

  // Apaga uma categoria
  void deleteCategory() {
    Get.defaultDialog(
      title: 'Excluir Categoria',
      content: Text(
        'Deseja realmente excluir a categoria?',
        textAlign: TextAlign.center,
      ),
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        _categoriesRepository.deleteCategory(
          userUid: user!.id,
          catUid: categoryId,
          catName: categoryName,
        );
        Get.back();
      },
      buttonColor: AppColors.themeColor,
      radius: 5.0,
    );
  }
}
