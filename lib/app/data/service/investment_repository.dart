import '../model/investment_model.dart';
import '../provider/investment_provider.dart';

class InvestmentRepository {
  final InvestmentProvider _investmentProvider = InvestmentProvider();

  Stream<List<InvestmentModel>> getAllInvestment({required String userUid}) {
    return _investmentProvider.getAllInvestment(userUid: userUid);
  }

  Stream<List<InvestmentModel>> getAllInvestmentPeriod({
    required String userUid,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _investmentProvider.getAllInvestmentPeriod(
      userUid: userUid,
      initialDate: initialDate,
      endDate: endDate,
    );
  }

  Stream<List<InvestmentModel>> getAllInvestmentLastYear({
    required String userUid,
  }) {
    return _investmentProvider.getAllInvestmentLastYear(userUid: userUid);
  }

  Future<void> addInvestment(
      {required String userUid,
      required double invValue,
      required bool invMadeEffective,
      required DateTime invDate,
      required String invDescription,
      required String invAddInformation}) async {
    return _investmentProvider.addInvestment(
      userUid: userUid,
      invValue: invValue,
      invMadeEffective: invMadeEffective,
      invDate: invDate,
      invDescription: invDescription,
      invAddInformation: invAddInformation,
    );
  }

  Future updateInvestment(
      {required String userUid,
      required double invValue,
      required bool invMadeEffective,
      required DateTime invDate,
      required String invDescription,
      required String invAddInformation,
      required String invUid}) async {
    return _investmentProvider.updateInvestment(
      userUid: userUid,
      invValue: invValue,
      invMadeEffective: invMadeEffective,
      invDate: invDate,
      invDescription: invDescription,
      invAddInformation: invAddInformation,
      invUid: invUid,
    );
  }

  Future deleteInvestment({required String userUid, required invUid, required invDescription}) async {
    return _investmentProvider.deleteInvestment(
      userUid: userUid,
      invUid: invUid,
      invDescription: invDescription,
    );
  }
}
