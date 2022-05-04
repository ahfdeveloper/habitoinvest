import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/goals_repository.dart';
import '../../data/service/login_repository.dart';
import '../../data/service/parameters_repository.dart';
import '../../routes/routes.dart';

class WelcomeController extends GetxController {
  final LoginRepository _loginRepository = LoginRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final GoalsRepository _goalsRepository = GoalsRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();

  final box = GetStorage('habito_invest_app');

// Função que efetua o login social com a conta Google no app
  void googleSignIn() async {
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    UserModel? user = await _loginRepository.signInWithGoogle();

    if (user != null) {
      _loginRepository.verifyUserInBD(
        userUid: user.id,
        name: user.name,
        email: user.email,
      );
      box.write('auth', user);

      _accountRepository.verifyAccountInBD(userUid: user.id);
      _goalsRepository.verifyGoalInBD(userUid: user.id);
      _parametersRepository.verifyParameterInBD(userUid: user.id);

      Get.offAllNamed(Routes.HOME, arguments: {'user': user});
    }
  }
}
