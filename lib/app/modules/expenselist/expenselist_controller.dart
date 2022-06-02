import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';
import 'package:habito_invest_app/app/data/model/parameters_model.dart';
import 'package:habito_invest_app/app/data/service/parameters_repository.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/account_model.dart';
import '../../data/model/expense_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/expense_repository.dart';
import '../../global_widgets/app_snackbar.dart';

class ExpenseListController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();

  // Campo para busca de despesas que aparece na appBar quando toca na lupa
  late TextEditingController searchFormFieldController = TextEditingController();

  // Indica quando o botão de procurar foi clicado ou não
  RxBool _searchBoolean = false.obs;
  get searchBoolean => this._searchBoolean.value;
  set searchBoolean(value) => this._searchBoolean.value = value;

  String _expenseId = '';
  String get expenseId => this._expenseId;
  set expenseId(String value) => this._expenseId = value;

  String _expenseDescription = '';
  String get expenseDescription => this._expenseDescription;
  set expenseDescription(String value) => this._expenseDescription = value;

  double _expenseValue = 0.0;
  double get expenseValue => this._expenseValue;
  set expenseValue(double value) => this._expenseValue = value;

  bool _expensePay = false;
  bool get expensePay => this._expensePay;
  set expensePay(bool value) => this._expensePay = value;

  // Cor do texto do botão "Todos os períodos"
  Rx<Color> _buttonTextColorAllPeriod = AppColors.expenseColor.obs;
  Color get buttonTextColorAllPeriod => this._buttonTextColorAllPeriod.value;
  set buttonTextColorAllPeriod(Color value) => this._buttonTextColorAllPeriod.value = value;

  // Cor de fundo do botão "Todos os períodos"
  Rx<Color> _buttonBackgroundColorallPeriod = AppColors.white.obs;
  Color get buttonBackgroundColorallPeriod => this._buttonBackgroundColorallPeriod.value;
  set buttonBackgroundColorallPeriod(Color value) => this._buttonBackgroundColorallPeriod.value = value;

  // Cor do texto do botão "Período atual"
  Rx<Color> _buttonTextColorCurrentPeriod = AppColors.white.obs;
  Color get buttonTextColorCurrentPeriod => this._buttonTextColorCurrentPeriod.value;
  set buttonTextColorCurrentPeriod(Color value) => this._buttonTextColorCurrentPeriod.value = value;

  // Cor de fundo do botão "Período atual"
  Rx<Color> _buttonBackgroundColorCurrentPeriod = AppColors.expenseColor.obs;
  Color get buttonBackgroundColorCurrentPeriod => this._buttonBackgroundColorCurrentPeriod.value;
  set buttonBackgroundColorCurrentPeriod(Color value) => this._buttonBackgroundColorCurrentPeriod.value = value;

  // Cor do texto do botão "Períodos Futuros"
  Rx<Color> _buttonTextColorFuturePeriod = AppColors.white.obs;
  Color get buttonTextColorFuturePeriod => this._buttonTextColorFuturePeriod.value;
  set buttonTextColorFuturePeriod(Color value) => this._buttonTextColorFuturePeriod.value = value;

  // Cor de fundo do botão "Períodos Futuros"
  Rx<Color> _buttonBackgroundColorFuturePeriod = AppColors.expenseColor.obs;
  Color get buttonBackgroundColorFuturePeriod => this._buttonBackgroundColorFuturePeriod.value;
  set buttonBackgroundColorFuturePeriod(Color value) => this._buttonBackgroundColorFuturePeriod.value = value;

  // Variável que guarda a lista de despesas
  Rx<List<ExpenseModel>> _expenseMainList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expenseMainList => this._expenseMainList.value;
  set expenseMainList(List<ExpenseModel> value) => this._expenseMainList.value = value;

  // Variável que guarda a lista de despesas
  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expenseList => this._expenseList.value;
  set expenseList(List<ExpenseModel> value) => this._expenseList.value = value;

  // Variável que guarda os dados da conta
  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  // Variável que guarda os dados da conta
  Rx<List<ParametersModel>> _parametersList = Rx<List<ParametersModel>>([]);
  List<ParametersModel> get parametersList => _parametersList.value;

  // Variável usada para fazer o filtro por nome na busca de uma despesa na appbar
  Rx<List<ExpenseModel>> _result = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get result => this._result.value;
  set result(List<ExpenseModel> value) => this._result.value = value;

  @override
  void onInit() {
    _expenseMainList.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    _result.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    _parametersList.bindStream(_parametersRepository.getAllParameters(userUid: user!.id));
    _expenseMainList = _expenseList;
    super.onInit();
  }

  //Apaga uma despesa
  void deleteExpense() {
    Get.defaultDialog(
      titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
      title: 'Excluir Despesa',
      middleText: 'Deseja realmente excluir esta despesa?',
      buttonColor: AppColors.themeColor,
      textCancel: 'Cancelar',
      cancelTextColor: AppColors.themeColor,
      textConfirm: 'OK',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        if (expensePay == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! + expenseValue,
            accValueLT: expenseValue,
            accTypeLT: 'Delete Expense',
            accDateLT: DateTime.now(),
            accUid: _accountList.value.first.id!,
          );
        }
        _expenseRepository.deleteExpense(userUid: user!.id, expUid: expenseId, expDescription: expenseDescription).whenComplete(
              () => AppSnackbar.snackarStyle(
                title: expenseDescription,
                message: 'Despesa apagada com sucesso',
              ),
            );
        Get.back();
      },
    );
  }

  // Faz a mudança de cor do indicador de pago ou não no ListTile
  Color? colorPay(bool pay) {
    if (pay == true) {
      return AppColors.expenseColor;
    } else {
      return AppColors.grey400;
    }
  }

  // Filtra os dados de acordo com a descrição digitada pelo usuário
  void runFilter(enteredKeyworld) {
    enteredKeyworld = searchFormFieldController.text;
    expenseList = result.where((income) => income.description!.toLowerCase().contains(enteredKeyworld.toLowerCase())).toList();
  }

  // Calcula horas de trabalho equivalentes para a despesa selecionada
  double workedCost(value) {
    if (parametersList.first.workedHours != 0) {
      double monthHours = parametersList.first.workedHours! * 4.5;
      return value / (parametersList.first.salary! / monthHours);
    } else {
      return 0;
    }
  }

  void allPeriodTransactions() async {
    buttonTextColorAllPeriod = AppColors.expenseColor;
    buttonBackgroundColorallPeriod = AppColors.white;
    buttonTextColorCurrentPeriod = AppColors.white;
    buttonBackgroundColorCurrentPeriod = AppColors.expenseColor;
    buttonTextColorFuturePeriod = AppColors.white;
    buttonBackgroundColorFuturePeriod = AppColors.expenseColor;
    _expenseMainList.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
  }

  void currentPeriodTransactions() async {
    DateTime _now = DateTime.now();
    buttonTextColorAllPeriod = AppColors.white;
    buttonBackgroundColorallPeriod = AppColors.expenseColor;
    buttonTextColorCurrentPeriod = AppColors.expenseColor;
    buttonBackgroundColorCurrentPeriod = AppColors.white;
    buttonTextColorFuturePeriod = AppColors.white;
    buttonBackgroundColorFuturePeriod = AppColors.expenseColor;
    _expenseMainList.bindStream(
      _expenseRepository.getAllExpensePeriod(
        userUid: user!.id,
        initialDate: getInitialCurrentPeriod(dayInitialPeriod: parametersList.first.dayInitialPeriod!),
        endDate: _now,
      ),
    );
  }

  void futurePeriodTransactions() async {
    buttonTextColorAllPeriod = AppColors.white;
    buttonBackgroundColorallPeriod = AppColors.expenseColor;
    buttonTextColorCurrentPeriod = AppColors.white;
    buttonBackgroundColorCurrentPeriod = AppColors.expenseColor;
    buttonTextColorFuturePeriod = AppColors.expenseColor;
    buttonBackgroundColorFuturePeriod = AppColors.white;
  }
}
