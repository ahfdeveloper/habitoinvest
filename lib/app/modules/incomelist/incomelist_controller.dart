import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/account_model.dart';
import '../../data/model/income_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/income_repository.dart';
import '../../global_widgets/app_snackbar.dart';

class IncomeListController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final IncomeRepository _incomeRepository = IncomeRepository();
  final AccountRepository _accountRepository = AccountRepository();

  // Campo que aparece na appBar para fazer busca de receitas
  late TextEditingController searchFormFieldController = TextEditingController();

  // Indica quando o botão de procurar foi clicado ou não
  RxBool _searchBoolean = false.obs;
  get searchBoolean => this._searchBoolean.value;
  set searchBoolean(value) => this._searchBoolean.value = value;

  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  double _incomeValue = 0.0;
  double get incomeValue => this._incomeValue;
  set incomeValue(double value) => this._incomeValue = value;

  String _incomeDescription = '';
  String get incomeDescription => this._incomeDescription;
  set incomeDescription(String value) => this._incomeDescription = value;

  bool _incomeReceived = false;
  bool get incomeReceived => this._incomeReceived;
  set incomeReceived(bool value) => this._incomeReceived = value;

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeList => this._incomeList.value;
  set incomeList(List<IncomeModel> value) => this._incomeList.value = value;

  Rx<List<IncomeModel>> _result = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get result => this._result.value;
  set result(List<IncomeModel> value) => this._result.value = value;

  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  @override
  void onInit() {
    _incomeList.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    _result.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    super.onInit();
  }

  //Apaga uma receita
  void deleteIncome() {
    Get.defaultDialog(
      titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
      title: 'Excluir Receita',
      middleText: 'Deseja realmente excluir esta receita?',
      buttonColor: AppColors.themeColor,
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        if (incomeReceived == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! - incomeValue,
            accValueLT: incomeValue,
            accTypeLT: 'Delete Income',
            accDateLT: DateTime.now(),
            accUid: _accountList.value.first.id!,
          );
        }
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
    );
  }

  // Faz a mudança de cor do indicador de recebido ou não no ListTile
  Color? colorReceived(bool received) {
    if (received == true) {
      return AppColors.incomeColor;
    } else {
      return AppColors.grey300;
    }
  }

// Filtra os dados de acordo com a descrição digitada pelo usuário
  void runFilter(enteredKeyworld) {
    enteredKeyworld = searchFormFieldController.text;
    incomeList = result.where((income) => income.description!.toLowerCase().contains(enteredKeyworld.toLowerCase())).toList();
  }
}
