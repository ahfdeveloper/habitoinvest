import '../model/income_model.dart';
import '../provider/income_provider.dart';

class IncomeRepository {
  final IncomeProvider _incomeProvider = IncomeProvider();

  Stream<List<IncomeModel>> getAllIncome({required String userUid}) {
    return _incomeProvider.getAllIncome(userUid: userUid);
  }

  Stream<List<IncomeModel>> getIncomeCurrent({required String userUid, required int dayInitial}) {
    return _incomeProvider.getIncomeCurrent(userUid: userUid, dayInitial: dayInitial);
  }

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
