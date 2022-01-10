import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';

class ExpenseListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  String _expenseId = '';
  String get expenseId => this._expenseId;
  set expenseId(String value) => this._expenseId = value;

  String _expenseDescription = '';
  String get expenseDescription => this._expenseDescription;
  set expenseDescription(String value) => this._expenseDescription = value;

  // Variável que guarda a lista de despesas
  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expense => _expenseList.value;

  @override
  void onInit() {
    _expenseList.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    super.onInit();
  }

  //Apaga uma despesa
  void deleteExpense() {
    Get.defaultDialog(
      title: 'Excluir Despesa',
      content: Text(
        'Deseja realmente excluir esta despesa?',
        textAlign: TextAlign.center,
      ),
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        _expenseRepository.deleteExpense(userUid: user!.id, expUid: expenseId, expDescription: expenseDescription).whenComplete(
              () => AppSnackbar.snackarStyle(
                title: expenseDescription,
                message: 'Despesa apagada com sucesso',
              ),
            );

        Get.back();
      },
      buttonColor: AppColors.themeColor,
      radius: 5.0,
    );
  }
}
