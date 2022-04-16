import 'package:get/get.dart';

import '../../data/model/user_model.dart';
import '../../data/service/goals_repository.dart';

class GoalsWarningController extends GetxController {
  final UserModel? user = Get.arguments;
  GoalsRepository _goalsRepository = GoalsRepository();

  // Cadastra todas as metas
  void addGoal() {
    _goalsRepository.addGoal(userUid: user!.id);
  }
}
