import 'package:get/get.dart';

import '../../core/utils/app_functions.dart';
import '../../data/model/account_model.dart';
import '../../data/model/expense_model.dart';
import '../../data/model/goals_model.dart';
import '../../data/model/income_model.dart';
import '../../data/model/investment_model.dart';
import '../../data/model/parameters_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/expense_repository.dart';
import '../../data/service/goals_repository.dart';
import '../../data/service/income_repository.dart';
import '../../data/service/investment_repository.dart';
import '../../data/service/parameters_repository.dart';

class HomeController extends GetxController {
  final UserModel? user = Get.arguments;
  final GoalsRepository _goalsRepository = GoalsRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final IncomeRepository _incomeRepository = IncomeRepository();
  final InvestmentRepository _investmentRepository = InvestmentRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();

  Rx<List<GoalsModel>> _goalsList = Rx<List<GoalsModel>>([]);
  List<GoalsModel> get goalsList => this._goalsList.value;

  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expenseList => this._expenseList.value;

  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => this._accountList.value;

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeList => _incomeList.value;

  Rx<List<InvestmentModel>> _investimentList = Rx<List<InvestmentModel>>([]);
  List<InvestmentModel> get investimentList => _investimentList.value;

  Rx<List<ParametersModel>> _parametersList = Rx<List<ParametersModel>>([]);
  List<ParametersModel> get parametersList => _parametersList.value;

  // Armazena o valor total de receitas no período atual do usuário
  double _totalIncome = 0.0;
  double get totalIncome => this._totalIncome;
  set totalIncome(double value) => this._totalIncome = value;

  // Armazena o valor total de despesas não essenciais no período atual do usuário
  RxDouble _totalNotEssencialExpenses = 0.0.obs;
  double get totalNotEssencialExpenses => this._totalNotEssencialExpenses.value;
  set totalNotEssencialExpenses(double value) => this._totalNotEssencialExpenses.value = value;

  // Armazena o valor total dos investimentos no período atual do usuário
  RxDouble _totalInvestments = 0.0.obs;
  double get totalInvestments => this._totalInvestments.value;
  set totalInvestments(double value) => this._totalInvestments.value = value;

  // Armazena a meta de investimento no período atual do usuário
  RxDouble _goalInvestiment = 0.0.obs;
  double get goalInvestiment => this._goalInvestiment.value;
  set goalInvestiment(double value) => this._goalInvestiment.value = value;

  // Armazena a meta de despesas não essenciais no período atual do usuário
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
    _parametersList.bindStream(_parametersRepository.getAllParameters(userUid: user!.id));
    _goalsList.bindStream(_goalsRepository.getAllGoals(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    _incomeList.bindStream(_incomeRepository.getAllIncome(userUid: user!.id));
    _expenseList.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    _investimentList.bindStream(_investmentRepository.getAllInvestment(userUid: user!.id));
    super.onInit();
  }

  // Retorna a meta de Gastos não essenciais
  double loadGoalExpenses() {
    if (goalsList.first.valueNotEssentialExpenses != 0.0) {
      goalNotEssentialExpenses = goalsList.first.valueNotEssentialExpenses!;
    } else {
      totalIncome = 0;
      incomeList.forEach((element) {
        if (element.date.isAfter(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).first) &&
            (element.date.isBefore(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).last)) &&
            element.received == true) {
          totalIncome = totalIncome + element.value!;
        }
      });
      goalNotEssentialExpenses = (goalsList.first.percentageNotEssentialExpenses! / 100) * totalIncome;
    }
    return goalNotEssentialExpenses;
  }

  // Retorna a meta de Investimentos
  double loadGoalInvestiment() {
    if (goalsList.first.valueInvestment != 0.0) {
      goalInvestiment = goalsList.first.valueInvestment!;
    } else {
      totalIncome = 0;
      incomeList.forEach((element) {
        if (element.date.isAfter(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).first) &&
            (element.date.isBefore(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).last)) &&
            element.received == true) {
          totalIncome = totalIncome + element.value!;
        }
      });
      goalInvestiment = (goalsList.first.percentageInvestiment! / 100) * totalIncome;
    }
    return goalInvestiment;
  }

  // Retorna os gastos não essenciais do período atual do usuário
  double loadNotEssencialExpensesCurrent() {
    totalNotEssencialExpenses = 0.0;
    expenseList.forEach((element) {
      if (element.date.isAfter(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).first) &&
          (element.date.isBefore(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).last)) &&
          element.quality == 'Não essencial' &&
          element.pay == true) {
        totalNotEssencialExpenses = totalNotEssencialExpenses + element.value!.toDouble();
      }
    });
    return totalNotEssencialExpenses;
  }

  // Retorna os investimentos no período atual do usuário
  double loadInvestmensCurrent() {
    totalInvestments = 0.0;
    investimentList.forEach((element) {
      if (element.date.isAfter(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).first) &&
          (element.date.isBefore(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).last)) &&
          element.madeEffective == true) {
        totalInvestments = totalInvestments + element.value!.toDouble();
      }
    });
    return totalInvestments;
  }

  // Calcula o equivalente das despesas não essenciais em horas de trabalho
  double loadWorkedHours() {
    double monthHours = parametersList.first.workedHours! * 4.5;
    return totalNotEssencialExpenses / (parametersList.first.salary! / monthHours);
  }

  int periodIndicator(DateTime finalDate) {
    List<DateTime> dates = getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!);
    DateTime from = DateTime(dates.first.year, dates.first.month, dates.first.day);
    DateTime to = DateTime(finalDate.year, finalDate.month, finalDate.day);
    return (to.difference(from).inHours / 24).round();
  }

  double percentagePeriodCurrent() {
    return periodIndicator(DateTime.now()) / periodIndicator(getInitialDateQuery(dayInitialPeriod: parametersList.first.dayInitialPeriod!).last);
  }

  // Index usado na NavigationBar
  void changePage(int index) async {
    currentIndex = index;
    update();
    print(currentIndex);
  }
}
