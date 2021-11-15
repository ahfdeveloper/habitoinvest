import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/provider/expense_provider.dart';

class ExpenseRepository {
  final ExpenseProvider _expenseProvider = ExpenseProvider();

  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _expenseProvider.getAllExpense(userUid: userUid);
  }
}
