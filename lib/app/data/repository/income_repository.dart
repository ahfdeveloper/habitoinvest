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
      required double incValue,
      required bool incReceived,
      required DateTime incDate,
      required String incDescription,
      required String incCategory,
      required String incAddInformation}) async {
    return _incomeProvider.addIncome(
        userUid: userUid,
        incValue: incValue,
        incReceived: incReceived,
        incDate: incDate,
        incDescription: incDescription,
        incCategory: incCategory,
        incAddInformation: incAddInformation);
  }

  // Atualiza uma receita editada
  Future updateIncome(
      {required String userUid,
      required double incValue,
      required bool incReceived,
      required DateTime incDate,
      required String incDescription,
      required String incCategory,
      required String incAddInformation,
      required String incUid}) async {
    return _incomeProvider.updateIncome(
      userUid: userUid,
      incValue: incValue,
      incReceived: incReceived,
      incDate: incDate,
      incDescription: incDescription,
      incCategory: incCategory,
      incAddInformation: incAddInformation,
      incUid: incUid,
    );
  }

  Future deleteIncome({required String userUid, required incUid, required incName}) async {
    return _incomeProvider.deleteIncome(userUid: userUid, incUid: incUid, incDescription: incName);
  }
}
