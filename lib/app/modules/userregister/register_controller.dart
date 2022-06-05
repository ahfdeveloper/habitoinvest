import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/goals_repository.dart';
import '../../data/service/login_repository.dart';
import '../../data/service/parameters_repository.dart';
import '../../routes/routes.dart';

class RegisterController extends GetxController {
  final LoginRepository _loginRepository = LoginRepository();
  final AccountRepository _accountRepository = Get.put(AccountRepository());
  final GoalsRepository _goalsRepository = Get.put(GoalsRepository());
  final ParametersRepository _parametersRepository = Get.put(ParametersRepository());

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final box = GetStorage('habito_invest_app');

  // Registra um usuário no App
  register() async {
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    UserModel? user = await _loginRepository.createUserWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
      name: nameTextController.text,
    );

    if (user != null) {
      // Cadastra o id do usuário como documento no Firestore
      _loginRepository.addUserFirestore(
        userUid: user.id,
        name: nameTextController.text,
        email: emailTextController.text + ' ',
      );

      // Cria uma conta no Firestore para esse usuário para controlar seu saldo
      _accountRepository.addAccount(userUid: user.id);

      // Cria metas zeradas para que o usuário altere depois
      _goalsRepository.addGoal(userUid: user.id);

      // Cria parâmetros default para o usuário
      _parametersRepository.addParameter(userUid: user.id);

      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
        transitionDuration: Duration(seconds: 2),
      );
      Get.defaultDialog(
        title: 'Cadastramento de usuário',
        content: Text(
          'Cadastro efetuado com sucesso, efetue login em sua conta',
          textAlign: TextAlign.center,
        ),
        textConfirm: 'OK',
        confirmTextColor: AppColors.white,
        buttonColor: AppColors.themeColor,
        radius: 5.0,
        onConfirm: () => Get.offAllNamed(Routes.LOGIN, arguments: user),
      );
    }
  }
}
