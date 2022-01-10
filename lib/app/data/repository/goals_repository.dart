import 'package:habito_invest_app/app/data/model/goals_model.dart';
import 'package:habito_invest_app/app/data/provider/goals_provider.dart';

class GoalsRepository {
  final GoalsProvider _goalsProvider = GoalsProvider();

  // Retorna as metas cadastradas
  Stream<List<GoalsModel>> getAllGoals({required String userUid}) {
    return _goalsProvider.getAllGoals(userUid: userUid);
  }
}
