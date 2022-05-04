import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/model/user_model.dart';
import '../../data/service/login_repository.dart';
import '../../routes/routes.dart';

class LoginController extends GetxController {
  final LoginRepository _loginRepository = LoginRepository();

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
      Get.offAllNamed(Routes.HOME, arguments: {'user': user});
    }
  }

  // Função que faz logout do usuário do app
  void logout() {
    _loginRepository.signOut();
    Get.offAllNamed(Routes.WELCOME);
  }
}
