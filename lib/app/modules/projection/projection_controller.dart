import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/model/goals_model.dart';
import 'package:habito_invest_app/app/data/model/parameters_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/modules/expense/expense_repository.dart';
import 'package:habito_invest_app/app/modules/goals/goals_repository.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_repository.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';

class ProjectionController extends GetxController {
  final UserModel? user = Get.arguments;
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();
  final GoalsRepository _goalsRepository = GoalsRepository();

  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expenseList => this._expenseList.value;

  Rx<List<ParametersModel>> _parametersList = Rx<List<ParametersModel>>([]);
  List<ParametersModel> get parametersList => _parametersList.value;

  Rx<List<GoalsModel>> _goalsList = Rx<List<GoalsModel>>([]);
  List<GoalsModel> get goalsList => this._goalsList.value;

  // Armazena o valor total de despesas não essenciais no período atual do usuário
  RxDouble _totalNotEssencialExpenses = 0.0.obs;
  double get totalNotEssencialExpenses => this._totalNotEssencialExpenses.value;
  set totalNotEssencialExpenses(double value) => this._totalNotEssencialExpenses.value = value;

  // Armazena o valor total de despesas não essenciais no período atual do usuário
  Rx<List<double>> _notEssencialExpenses = Rx<List<double>>([]);
  List<double> get notEssencialExpenses => this._notEssencialExpenses.value;
  set notEssencialExpenses(List<double> value) => this._notEssencialExpenses.value = value;

  // Armazena a meta de despesas não essenciais no período atual do usuário
  RxDouble _goalNotEssentialExpenses = 0.0.obs;
  double get goalNotEssentialExpenses => this._goalNotEssentialExpenses.value;
  set goalNotEssentialExpenses(double value) => this._goalNotEssentialExpenses.value = value;

  @override
  void onInit() {
    _expenseList.bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    _parametersList.bindStream(_parametersRepository.getAllParameters(userUid: user!.id));
    _goalsList.bindStream(_goalsRepository.getAllGoals(userUid: user!.id));
    super.onInit();
  }

  // Retorna a meta de Gastos não essenciais
  double loadGoalExpenses() {
    if (goalsList.first.valueNotEssentialExpenses != 0.0) {
      goalNotEssentialExpenses = goalsList.first.valueNotEssentialExpenses!;
    } else {
      goalNotEssentialExpenses = (goalsList.first.percentageNotEssentialExpenses! / 100) * parametersList.first.salary!;
    }
    return goalNotEssentialExpenses;
  }

  // Retorna os gastos não essenciais em cada um dos períodos futuros ao atual
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

  // Retorna os gastos não essenciais em cada um dos períodos futuros ao atual
  double loadNotEssencialExpensesFuture(int addMonthCurrent) {
    notEssencialExpenses.insert(addMonthCurrent - 1, 0.0);
    double value = 0;
    expenseList.forEach((element) {
      if (element.date.isAfter(getDateProjectionExpense(dayInitialPeriod: parametersList.first.dayInitialPeriod!, fowardMonth: addMonthCurrent).first) &&
          (element.date.isBefore(getDateProjectionExpense(dayInitialPeriod: parametersList.first.dayInitialPeriod!, fowardMonth: addMonthCurrent).last)) &&
          element.quality == 'Não essencial') {
        value = value + element.value!.toDouble();
      }
    });
    notEssencialExpenses.insert(addMonthCurrent - 1, value);
    return notEssencialExpenses.elementAt(addMonthCurrent - 1);
  }

  // Calcula o equivalente das despesas não essenciais em horas de trabalho
  double loadWorkedHours(int addMonthCurrent) {
    double monthHours = parametersList.first.workedHours! * 4.5;
    return notEssencialExpenses.elementAt(addMonthCurrent - 1) / (parametersList.first.salary! / monthHours);
  }

  List<DateTime> getPeriod(addMonthCurrent) {
    DateTime initialDate = getDateProjectionExpense(dayInitialPeriod: parametersList.first.dayInitialPeriod! + 1, fowardMonth: addMonthCurrent).first;
    DateTime finalDate = getDateProjectionExpense(dayInitialPeriod: parametersList.first.dayInitialPeriod! - 1, fowardMonth: addMonthCurrent).last;
    return [initialDate, finalDate];
  }
}
