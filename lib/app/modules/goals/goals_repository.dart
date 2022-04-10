import 'package:habito_invest_app/app/data/model/goals_model.dart';
import 'package:habito_invest_app/app/data/provider/goals_provider.dart';

class GoalsRepository {
  final GoalsProvider _goalsProvider = GoalsProvider();

  Stream<List<GoalsModel>> getAllGoals({required String userUid}) {
    return _goalsProvider.getAllGoals(userUid: userUid);
  }

  Future<void> verifyGoalInBD({required String userUid}) async {
    return _goalsProvider.verifyGoalInBD(userUid: userUid);
  }

  Future<void> addGoal({required String userUid}) async {
    return _goalsProvider.addGoal(userUid: userUid);
  }

  Future updateInvestiment({
    required String userUid,
    required DateTime gDate,
    required int gPercentageInvestment,
    required double gValueInvestment,
    required String gUid,
  }) async {
    return _goalsProvider.updateInvestiment(
      userUid: userUid,
      gDate: gDate,
      gPercentageInvestment: gPercentageInvestment,
      gValueInvestment: gValueInvestment,
      gUid: gUid,
    );
  }

  // Atualiza a meta gastos não essenciais
  Future updateNotEssentialExpense({
    required String userUid,
    required DateTime gDate,
    required int gPercentageNotEssentialExpenses,
    required double gValueNotEssentialExpenses,
    required String gUid,
  }) async {
    return _goalsProvider.updateNotEssentialExpense(
      userUid: userUid,
      gDate: gDate,
      gPercentageNotEssentialExpenses: gPercentageNotEssentialExpenses,
      gValueNotEssentialExpenses: gValueNotEssentialExpenses,
      gUid: gUid,
    );
  }
}
