import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/login_repository.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository = LoginRepository();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final box = GetStorage('habito_invest_app');

  // Função que efetua login do usuário através de e-mail e senha no app
  void login() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    UserModel? user = await loginRepository.signInWithEmailAndPassword(
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
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    UserModel? user = await loginRepository.signInWithGoogle();

    if (user != null) {
      loginRepository.verifyUserInBD(
        userUid: user.id,
        name: user.name,
        email: user.email,
      );
      box.write('auth', user);
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }

  // Função que faz logout do usuário do app
  void logout() {
    loginRepository.signOut();
    Get.offAllNamed(Routes.WELCOME);
  }
}
