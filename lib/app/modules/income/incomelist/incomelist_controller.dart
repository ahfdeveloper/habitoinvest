import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';

class IncomeListController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final IncomeRepository _incomeRepository = IncomeRepository();
  final UserModel? user = Get.arguments;

  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  String _incomeName = '';
  String get incomeName => this._incomeName;
  set incomeName(String value) => this._incomeName = value;

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get income => _incomeList.value;

  @override
  void onInit() {
    _incomeList.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    super.onInit();
  }

  // Apaga uma receita
  // void deleteCategory() {
  //   Get.defaultDialog(
  //     title: 'Excluir Categoria',
  //     content: Text(
  //       'Deseja realmente excluir a categoria?',
  //       textAlign: TextAlign.center,
  //     ),
  //     textCancel: 'Cancelar',
  //     cancelTextColor: AppColors.themeColor,
  //     textConfirm: 'OK',
  //     confirmTextColor: AppColors.white,
  //     onConfirm: () {
  //       _categoriesRepository.deleteCategory(
  //         userUid: user!.id,
  //         catUid: categoryId,
  //         catName: categoryName,
  //       );
  //       Get.back();
  //     },
  //     buttonColor: AppColors.themeColor,
  //     radius: 5.0,
  //   );
  // }
}
