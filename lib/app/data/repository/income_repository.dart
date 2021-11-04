import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/data/provider/income_provider.dart';

class IncomeRepository {
  final IncomeProvider _incomeProvider = IncomeProvider();

  // Lista todas as receitas
  Stream<List<IncomeModel>> getAllIncome({required String userUid}) {
    return _incomeProvider.getAllIncome(userUid: userUid);
  }

  // Cadastra uma nova receita
  Future<void> addIncome(
      {required String userUid,
      required DateTime incDate,
      required String incName,
      required String incCategory,
      required double incValue,
      required String incObservation}) async {
    return _incomeProvider.addIncome(
        userUid: userUid,
        incDate: incDate,
        incName: incName,
        incCategory: incCategory,
        incValue: incValue,
        incObservation: incObservation);
  }

  // Atualiza uma receita editada
  Future updateIncome(
      {required String userUid,
      required DateTime incDate,
      required String incName,
      required String incCategory,
      required double incValue,
      required String incObservation,
      required String incUid}) async {
    return _incomeProvider.updateIncome(
        userUid: userUid,
        incDate: incDate,
        incName: incName,
        incCategory: incCategory,
        incValue: incValue,
        incObservation: incObservation,
        incUid: incUid);
  }

  Future deleteIncome(
      {required String userUid, required incUid, required incName}) async {
    return _incomeProvider.deleteIncome(
        userUid: userUid, incUid: incUid, incName: incName);
  }
}
