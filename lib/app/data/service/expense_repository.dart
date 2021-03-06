import '../model/expense_model.dart';
import '../provider/expense_provider.dart';

class ExpenseRepository {
  final ExpenseProvider _expenseProvider = ExpenseProvider();

  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _expenseProvider.getAllExpense(userUid: userUid);
  }

  Stream<List<ExpenseModel>> getExpensePeriodWithCategQuality({
    required String userUid,
    required String category,
    required String expenseQuality,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _expenseProvider.getExpensePeriodWithCategQuality(
      userUid: userUid,
      category: category,
      expenseQuality: expenseQuality,
      initialDate: initialDate,
      endDate: endDate,
    );
  }

  Stream<List<ExpenseModel>> getExpensePeriodWithCategory({
    required String userUid,
    required String category,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _expenseProvider.getExpensePeriodWithCategory(
      userUid: userUid,
      category: category,
      initialDate: initialDate,
      endDate: endDate,
    );
  }

  Stream<List<ExpenseModel>> getExpensePeriodWithQuality({
    required String userUid,
    required String expenseQuality,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _expenseProvider.getExpensePeriodWithQuality(
      userUid: userUid,
      expenseQuality: expenseQuality,
      initialDate: initialDate,
      endDate: endDate,
    );
  }

  Stream<List<ExpenseModel>> getAllExpensePeriod({
    required String userUid,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _expenseProvider.getAllExpensePeriod(
      userUid: userUid,
      initialDate: initialDate,
      endDate: endDate,
    );
  }

  Stream<List<ExpenseModel>> getNotEssentialsExpenseLastYear({
    required String userUid,
  }) {
    return _expenseProvider.getNotEssentialsExpenseLastYear(userUid: userUid);
  }

  Stream<List<ExpenseModel>> getFuturePeriodExpense({
    required String userUid,
    required DateTime initialDate,
  }) {
    return _expenseProvider.getFuturePeriodExpense(userUid: userUid, initialDate: initialDate);
  }

  Future<void> addExpense(
      {required String userUid,
      required double expValue,
      required DateTime expDate,
      required String expDescription,
      required String expCategory,
      required String expQuality,
      required bool expPay,
      required String expAddInformation}) async {
    return _expenseProvider.addExpense(
      userUid: userUid,
      expValue: expValue,
      expDate: expDate,
      expDescription: expDescription,
      expCategory: expCategory,
      expQuality: expQuality,
      expPay: expPay,
      expAddInformation: expAddInformation,
    );
  }

  Future updateExpense(
      {required String userUid,
      required double expValue,
      required DateTime expDate,
      required String expDescription,
      required String expCategory,
      required String expQuality,
      required bool expPay,
      required String expAddInformation,
      required String expUid}) async {
    return _expenseProvider.updateExpense(
      userUid: userUid,
      expValue: expValue,
      expDate: expDate,
      expDescription: expDescription,
      expCategory: expCategory,
      expQuality: expQuality,
      expPay: expPay,
      expAddInformation: expAddInformation,
      expUid: expUid,
    );
  }

  Future deleteExpense({required String userUid, required expUid, required expDescription}) async {
    return _expenseProvider.deleteExpense(userUid: userUid, expUid: expUid, expDescription: expDescription);
  }

  Stream<List<ExpenseModel>> getExpensePeriodWithQualityPay({
    required String userUid,
    required String expenseQuality,
    required DateTime initialDate,
    required DateTime endDate,
    required bool pay,
  }) {
    return _expenseProvider.getExpensePeriodWithQualityPay(
      userUid: userUid,
      expenseQuality: expenseQuality,
      initialDate: initialDate,
      endDate: endDate,
      pay: pay,
    );
  }
}
