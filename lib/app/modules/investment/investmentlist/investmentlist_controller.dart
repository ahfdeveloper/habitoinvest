import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/investment_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/investment_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';

class InvestmentListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final InvestmentRepository _investmentRepository = InvestmentRepository();
  final AccountRepository _accountRepository = AccountRepository();

  late TextEditingController searchFormFieldController = TextEditingController();

  String _investmentId = '';
  String get investmentId => this._investmentId;
  set investmentId(String value) => this._investmentId = value;

  String _investmentDescription = '';
  String get investmentDescription => this._investmentDescription;
  set investmentDescription(String value) => this._investmentDescription = value;

  double _investmentValue = 0.0;
  double get investmentValue => this._investmentValue;
  set investmentValue(double value) => this._investmentValue = value;

  // Indica quando o botão de procurar foi clicado ou não
  RxBool _searchBoolean = false.obs;
  get searchBoolean => this._searchBoolean.value;
  set searchBoolean(value) => this._searchBoolean.value = value;

  // Recebe a lista de investimentos de acordo com a busca
  Rx<List<InvestmentModel>> _result = Rx<List<InvestmentModel>>([]);
  List<InvestmentModel> get result => _result.value;
  set result(List<InvestmentModel> value) => this._result.value = value;

  // Recebe a lista de investimentos
  Rx<List<InvestmentModel>> _investmentList = Rx<List<InvestmentModel>>([]);
  List<InvestmentModel> get investmentList => _investmentList.value;
  set investmentList(List<InvestmentModel> value) => this._investmentList.value = value;

  // Recebe os dados da conta
  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  @override
  void onInit() {
    _investmentList.bindStream(_investmentRepository.getAllInvestment(userUid: user!.id));
    _result.bindStream(_investmentRepository.getAllInvestment(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
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
      buttonColor: AppColors.themeColor,
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        _accountRepository.updateAccount(
          userUid: user!.id,
          accBalance: _accountList.value.first.balance! + investmentValue,
          accValueLT: investmentValue,
          accTypeLT: 'Delete Expense',
          accDateLT: DateTime.now(),
          accUid: _accountList.value.first.id!,
        );
        _investmentRepository.deleteInvestment(userUid: user!.id, invUid: investmentId, invDescription: investmentDescription).whenComplete(
              () => AppSnackbar.snackarStyle(
                title: investmentDescription,
                message: 'Investimento apagado com sucesso',
              ),
            );

        Get.back();
      },
    );
  }

// Filtra os dados de acordo com a descrição digitada pelo usuário
  void runFilter(enteredKeyworld) {
    enteredKeyworld = searchFormFieldController.text;
    investmentList = result.where((investment) => investment.description!.toLowerCase().contains(enteredKeyworld.toLowerCase())).toList();
  }
}
