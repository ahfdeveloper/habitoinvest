import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/provider/expense_provider.dart';

class ExpenseRepository {
  final ExpenseProvider _expenseProvider = ExpenseProvider();

  // Chama função do provider que retorna a lista de despesas
  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _expenseProvider.getAllExpense(userUid: userUid);
  }

  // Chama função do provider que cadastra uma nova despesa
  Future<void> addExpense(
      {required String userUid,
      required double expTotalValue,
      required bool expPay,
      required DateTime expDateShop,
      required String expDescription,
      required String expCategory,
      required String expQuality,
      required DateTime expDatePayFirstPortion,
      required String expPortionNumber,
      required String expTotalPortionNumber,
      required double expPortionValue,
      required String expAddInformation}) async {
    return _expenseProvider.addExpense(
        userUid: userUid,
        expTotalValue: expTotalValue,
        expPay: expPay,
        expDateShop: expDateShop,
        expDescription: expDescription,
        expCategory: expCategory,
        expQuality: expQuality,
        expDatePayFirstPortion: expDatePayFirstPortion,
        expPortionNumber: expPortionNumber,
        expTotalPortionNumber: expTotalPortionNumber,
        expPortionValue: expPortionValue,
        expAddInformation: expAddInformation);
  }
}
