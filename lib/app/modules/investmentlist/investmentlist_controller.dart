import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/account_model.dart';
import '../../data/model/investment_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/investment_repository.dart';
import '../../global_widgets/app_snackbar.dart';

class InvestmentListController extends GetxController {
  final UserModel? user = Get.arguments['user'];
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

  bool _investmentMadeEffective = false;
  bool get investmentMadeEffective => this._investmentMadeEffective;
  set investmentMadeEffective(bool value) => this._investmentMadeEffective = value;

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
      titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
      title: 'Excluir Investimento',
      middleText: 'Deseja realmente excluir este investimento?',
      buttonColor: AppColors.themeColor,
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        if (investmentMadeEffective == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! + investmentValue,
            accValueLT: investmentValue,
            accTypeLT: 'Delete Expense',
            accDateLT: DateTime.now(),
            accUid: _accountList.value.first.id!,
          );
        }
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
