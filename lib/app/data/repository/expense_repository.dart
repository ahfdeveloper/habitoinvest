import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/provider/expense_provider.dart';

class ExpenseRepository {
  final ExpenseProvider _expenseProvider = ExpenseProvider();

  // Chama função do provider que retorna a lista de despesas
  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _expenseProvider.getAllExpense(userUid: userUid);
  }

  //Retorna todos os gastos não essenciais pagos no período atual
  Stream<List<ExpenseModel>> getNotEssencExpCurrent({required String userUid, required int dayInitial}) {
    return _expenseProvider.getNotEssencExpCurrent(userUid: userUid, dayInitial: dayInitial);
  }

  // Chama função do provider que cadastra uma nova despesa
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

  // Atualiza uma despesa editada
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

  // Chama a dunção do provider que apaga uma despesa
  Future deleteExpense({required String userUid, required expUid, required expDescription}) async {
    return _expenseProvider.deleteExpense(userUid: userUid, expUid: expUid, expDescription: expDescription);
  }
}
