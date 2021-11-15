import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar.dart';

class CategoriesListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final IncomeRepository _incomeRepository = IncomeRepository();

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get income => _incomeList.value;

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
    _categoriesList
        .bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _incomeList.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    super.onInit();
  }

  // Verifica se existem receitadas cadastradas em determinada categoria
  bool verifyCategoryIncome() {
    bool haveCategory = false;
    for (final i in income) {
      if (i.category == categoryName) {
        Get.defaultDialog(
          title: 'Excluir categoria',
          content: Text(
            'Exclusão não permitida, pois existe(m) receita(a)s/despesa(s) cadastradas usando esta categoria',
            textAlign: TextAlign.center,
          ),
          textConfirm: 'OK',
          confirmTextColor: AppColors.white,
          onConfirm: () {
            Get.back();
          },
          buttonColor: AppColors.themeColor,
          radius: 5.0,
        );
        haveCategory = true;
        break;
      }
    }
    return haveCategory;
  }

  // Apaga uma categoria
  void deleteCategory() async {
    await Get.defaultDialog(
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
        _categoriesRepository
            .deleteCategory(
              userUid: user!.id,
              catUid: categoryId,
              catName: categoryName,
            )
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                  title: categoryName,
                  message: 'Categoria apagada com sucesso'),
            );
        Get.back();
      },
      buttonColor: AppColors.themeColor,
      radius: 5.0,
    );
  }
}
