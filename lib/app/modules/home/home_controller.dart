import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/model/goals_model.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/model/investment_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';
import 'package:habito_invest_app/app/data/repository/goals_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import 'package:habito_invest_app/app/data/repository/investment_repository.dart';

class HomeController extends GetxController {
  final UserModel? user = Get.arguments;
  GoalsRepository _goalsRepository = GoalsRepository();
  AccountRepository _accountRepository = AccountRepository();
  ExpenseRepository _expenseRepository = ExpenseRepository();
  IncomeRepository _incomeRepository = IncomeRepository();
  InvestmentRepository _investmentRepository = InvestmentRepository();

  Rx<List<GoalsModel>> _goalsList = Rx<List<GoalsModel>>([]);
  List<GoalsModel> get goalsList => this._goalsList.value;
  set goalsList(List<GoalsModel> value) => this._goalsList.value = value;

  Rx<List<ExpenseModel>> _notEssExpCurrent = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get notEssExpCurrent => this._notEssExpCurrent.value;
  set notEssExpCurrent(List<ExpenseModel> value) => this._notEssExpCurrent.value = value;

  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => this._accountList.value;
  set accountList(List<AccountModel> value) => this._accountList.value = value;

  Rx<List<IncomeModel>> _incomeListCurrent = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeListCurrent => _incomeListCurrent.value;
  set incomeListCurrent(List<IncomeModel> value) => this._incomeListCurrent.value = value;

  Rx<List<InvestmentModel>> _investimentListCurrent = Rx<List<InvestmentModel>>([]);
  List<InvestmentModel> get investimentListCurrent => _investimentListCurrent.value;
  set investimentListCurrent(List<InvestmentModel> value) => this._investimentListCurrent.value = value;

  RxString _balance = ''.obs;
  String get balance => this._balance.value;
  set balance(String value) => this._balance.value = value;

  // Armazena o valor total de despesas não essenciais no período atual do usuário
  RxDouble _totalNotEssencialExpenses = 0.0.obs;
  double get totalNotEssencialExpenses => this._totalNotEssencialExpenses.value;
  set totalNotEssencialExpenses(double value) => this._totalNotEssencialExpenses.value = value;

  // Armazena o valor total dos investimentos no período atual do usuário
  RxDouble _totalInvestments = 0.0.obs;
  double get totalInvestments => this._totalInvestments.value;
  set totalInvestments(double value) => this._totalInvestments.value = value;

  // Armazena o valor total de receitas no período atual do usuário
  RxDouble _goalInvestiment = 0.0.obs;
  double get goalInvestiment => this._goalInvestiment.value;
  set goalInvestiment(double value) => this._goalInvestiment.value = value;

  double _totalIncome = 0.0;
  double get totalIncome => this._totalIncome;
  set totalIncome(double value) => this._totalIncome = value;

  // Armazena o valor total de receitas no período atual do usuário
  RxDouble _goalNotEssentialExpenses = 0.0.obs;
  double get goalNotEssentialExpenses => this._goalNotEssentialExpenses.value;
  set goalNotEssentialExpenses(double value) => this._goalNotEssentialExpenses.value = value;

  // Setter e Getter para variável currentIndex, para que a responsabilidade pela
  // alteração dos estados fique sob responsabilidade do controller
  RxInt _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(value) => this._currentIndex.value = value;

  @override
  void onInit() {
    _goalsList.bindStream(_goalsRepository.getAllGoals(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    _notEssExpCurrent.bindStream(_expenseRepository.getNotEssencExpCurrent(userUid: user!.id, dayInitial: 20));
    _incomeListCurrent.bindStream(_incomeRepository.getIncomeCurrent(userUid: user!.id, dayInitial: 20));
    _investimentListCurrent.bindStream(_investmentRepository.getInvestmentCurrent(userUid: user!.id, dayInitial: 20));
    super.onInit();
  }

  // Retorna a meta de Gastos não essenciais
  loadGoalExpenses() {
    if (goalsList.first.valueNotEssentialExpenses != 0.0) {
      return Text('Meta: R\$${goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2)}');
    } else {
      totalIncome = 0;
      incomeListCurrent.forEach((element) {
        totalIncome = totalIncome + element.value!;
      });
      goalNotEssentialExpenses = (goalsList.first.percentageNotEssentialExpenses! / 100) * totalIncome;
      //print('Meta de despesas não essenciais: $goalNotEssentialExpenses');
      return Text('Meta: R\$${goalNotEssentialExpenses.toStringAsFixed(2)}');
    }
  }

  // Retorna a meta de Investimentos
  loadGoalInvestiment() {
    if (goalsList.first.valueInvestment != 0.0) {
      return Text('Meta: R\$${goalsList.first.valueInvestment!.toStringAsFixed(2)}');
    } else {
      totalIncome = 0;
      incomeListCurrent.forEach((element) {
        totalIncome = totalIncome + element.value!;
      });
      goalInvestiment = (goalsList.first.percentageInvestiment! / 100) * totalIncome;
      //print('Meta de Investimentos: $goalInvestiment');
      return Text('Meta: R\$${goalInvestiment.toStringAsFixed(2)}');
    }
  }

  // Retorna os gastos não essenciais do período atual
  Widget loadNotEssencialExpensesCurrent() {
    totalNotEssencialExpenses = 0.0;
    notEssExpCurrent.forEach((element) {
      totalNotEssencialExpenses = totalNotEssencialExpenses + element.value!.toDouble();
    });
    //print('Despesas efetivadas $totalNotEssencialExpenses');
    return Text('Despesas: R\$${totalNotEssencialExpenses.toStringAsFixed(2)}');
  }

  // Retorna os investimentos no período atual
  Widget loadInvestmensCurrent() {
    totalInvestments = 0.0;
    investimentListCurrent.forEach((element) {
      totalInvestments = totalInvestments + element.value!.toDouble();
    });
    //print('Investimentos efetivados $totalInvestments');
    return Text('Investido: R\$${totalInvestments.toStringAsFixed(2)}');
  }

  // Index usado na NavigationBar
  void changePage(int index) async {
    currentIndex = index;
  }
}
