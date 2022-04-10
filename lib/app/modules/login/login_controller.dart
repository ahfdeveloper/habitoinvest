import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/modules/goals/goals_repository.dart';
import 'package:habito_invest_app/app/modules/login/login_repository.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_repository.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginRepository _loginRepository = LoginRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final GoalsRepository _goalsRepository = GoalsRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final box = GetStorage('habito_invest_app');

  // Função que efetua login do usuário através de e-mail e senha no app
  void login() async {
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    UserModel? user = await _loginRepository.signInWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
    );
    if (user != null) {
      box.write('auth', user);
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }

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

      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }

  // Função que faz logout do usuário do app
  void logout() {
    _loginRepository.signOut();
    Get.offAllNamed(Routes.WELCOME);
  }
}
