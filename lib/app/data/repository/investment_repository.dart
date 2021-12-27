import 'package:habito_invest_app/app/data/model/investment_model.dart';
import 'package:habito_invest_app/app/data/provider/investment_provider.dart';

class InvestmentRepository {
  final InvestmentProvider _investmentProvider = InvestmentProvider();

  //Retorna todos os investimentos cadastrados
  Stream<List<InvestmentModel>> getAllInvestment({required String userUid}) {
    return _investmentProvider.getAllInvestment(userUid: userUid);
  }

  // Cadastra um novo investimento
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

  // Atualiza um investimento cadastrado
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

  // Deleta um investimento
  Future deleteInvestment(
      {required String userUid,
      required invUid,
      required invDescription}) async {
    return _investmentProvider.deleteInvestment(
      userUid: userUid,
      invUid: invUid,
      invDescription: invDescription,
    );
  }
}
