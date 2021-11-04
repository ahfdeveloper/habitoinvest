import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar.dart';

class IncomeListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final IncomeRepository _incomeRepository = IncomeRepository();

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
        _incomeRepository
            .deleteIncome(
                userUid: user!.id, incUid: incomeId, incName: incomeName)
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                title: incomeName,
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
