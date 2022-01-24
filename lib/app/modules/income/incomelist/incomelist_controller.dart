import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';

class IncomeListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final IncomeRepository _incomeRepository = IncomeRepository();
  final AccountRepository _accountRepository = AccountRepository();

  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  double _incomeValue = 0.0;
  double get incomeValue => this._incomeValue;
  set incomeValue(double value) => this._incomeValue = value;

  String _incomeDescription = '';
  String get incomeDescription => this._incomeDescription;
  set incomeDescription(String value) => this._incomeDescription = value;

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeList => _incomeList.value;
  set incomeList(List<IncomeModel> value) => this._incomeList.value = value;

  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  @override
  void onInit() {
    _incomeList.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    super.onInit();
  }

  //Apaga uma receita
  void deleteIncome() {
    Get.defaultDialog(
      title: 'Excluir Receita',
      content: Text(
        'Deseja realmente excluir esta receita?',
        textAlign: TextAlign.center,
      ),
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        _accountRepository.updateAccount(
          userUid: user!.id,
          accBalance: _accountList.value.first.balance! - incomeValue,
          accValueLT: incomeValue,
          accTypeLT: 'Delete Income',
          accDateLT: DateTime.now(),
          accUid: _accountList.value.first.id!,
        );
        _incomeRepository
            .deleteIncome(
              userUid: user!.id,
              incUid: incomeId,
              incName: incomeDescription,
            )
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                title: incomeDescription,
                message: 'Receita apagada com sucesso',
              ),
            );

        Get.back();
      },
      buttonColor: AppColors.themeColor,
      radius: 5.0,
    );
  }
}
