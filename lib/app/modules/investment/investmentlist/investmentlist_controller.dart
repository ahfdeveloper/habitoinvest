import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/investment_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/investment_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';

class InvestmentListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final InvestmentRepository _investmentRepository = InvestmentRepository();

  String _investmentId = '';
  String get investmentId => this._investmentId;
  set investmentId(String value) => this._investmentId = value;

  String _investmentDescription = '';
  String get investmentDescription => this._investmentDescription;
  set investmentDescription(String value) => this._investmentDescription = value;

  Rx<List<InvestmentModel>> _investmentList = Rx<List<InvestmentModel>>([]);
  List<InvestmentModel> get investmentList => _investmentList.value;
  set investmentList(List<InvestmentModel> value) => this._investmentList.value = value;

  @override
  void onInit() {
    _investmentList.bindStream(_investmentRepository.getAllInvestment(userUid: user!.id));
    super.onInit();
  }

  //Apaga um investimento
  void deleteInvestment() {
    Get.defaultDialog(
      title: 'Excluir Investimento',
      content: Text(
        'Deseja realmente excluir este investimento?',
        textAlign: TextAlign.center,
      ),
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        _investmentRepository.deleteInvestment(userUid: user!.id, invUid: investmentId, invDescription: investmentDescription).whenComplete(
              () => AppSnackbar.snackarStyle(
                title: investmentDescription,
                message: 'Invesimento apagado com sucesso',
              ),
            );

        Get.back();
      },
      buttonColor: AppColors.themeColor,
      radius: 5.0,
    );
  }
}
