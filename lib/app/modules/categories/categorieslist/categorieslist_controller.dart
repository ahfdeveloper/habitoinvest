import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/app_snackbar.dart';

class CategoriesListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final IncomeRepository _incomeRepository = IncomeRepository();
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  late TextEditingController searchFormFieldController = TextEditingController();

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeList => _incomeList.value;

  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expenseList => _expenseList.value;

  // Indica quando o botão de procurar foi clicado ou não
  RxBool _searchBoolean = false.obs;
  get searchBoolean => this._searchBoolean.value;
  set searchBoolean(value) => this._searchBoolean.value = value;

  String _categoryId = '';
  String get categoryId => this._categoryId;
  set categoryId(String value) => this._categoryId = value;

  String _categoryName = '';
  String get categoryName => this._categoryName;
  set categoryName(String value) => this._categoryName = value;

  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categoriesList => _categoriesList.value;
  set categoriesList(List<CategoryModel> value) => this._categoriesList.value = value;

  Rx<List<CategoryModel>> _result = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get result => this._result.value;
  set result(List<CategoryModel> value) => this._result.value = value;

  @override
  void onInit() {
    _categoriesList.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _result.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _incomeList.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    _expenseList.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    super.onInit();
  }

  // Verifica se existem receitadas cadastradas em determinada categoria
  bool verifyCategoryIncome() {
    bool haveCategory = false;
    for (final i in incomeList) {
      if (i.category == categoryName) {
        Get.defaultDialog(
          titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
          title: 'Excluir categoria',
          middleText: 'Exclusão não permitida, pois existe(m) receita(s) cadastradas usando esta categoria',
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

  // Verifica se existem receitadas cadastradas em determinada categoria
  bool verifyCategoryExpense() {
    bool haveCategory = false;
    for (final i in expenseList) {
      if (i.category == categoryName) {
        Get.defaultDialog(
          titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
          title: 'Excluir categoria',
          middleText: 'Exclusão não permitida, pois existe(m) despesa(s) cadastradas usando esta categoria',
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
      titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
      title: 'Excluir Categoria',
      middleText: 'Deseja realmente excluir a categoria?',
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
              () => AppSnackbar.snackarStyle(title: categoryName, message: 'Categoria apagada com sucesso'),
            );
        Get.back();
      },
      buttonColor: AppColors.themeColor,
      radius: 5.0,
    );
  }

  // Filtra os dados de acordo com a descrição digitada pelo usuário
  void runFilter(enteredKeyworld) {
    enteredKeyworld = searchFormFieldController.text;
    categoriesList = result.where((category) => category.name!.toLowerCase().contains(enteredKeyworld.toLowerCase())).toList();
  }
}
