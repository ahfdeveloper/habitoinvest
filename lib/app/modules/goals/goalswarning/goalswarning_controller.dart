import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/modules/goals/goals_repository.dart';

class GoalsWarningController extends GetxController {
  final UserModel? user = Get.arguments;
  GoalsRepository _goalsRepository = GoalsRepository();

  // Cadastra todas as metas
  void addGoal() {
    _goalsRepository.addGoal(userUid: user!.id);
  }
}
