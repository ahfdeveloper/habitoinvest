import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/login_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class RegisterController extends GetxController {
  final LoginRepository loginRepository = LoginRepository();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final box = GetStorage('habito_invest_app');

  // Registra um usuário no App
  register() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    UserModel? user = await loginRepository.createUserWithEmailAndPassword(
      email: emailTextController.text,
      password: passwordTextController.text,
      name: nameTextController.text,
    );

    if (user != null) {
      // Cadastra o id do usuário como documento no Firestore
      loginRepository.addUserFirestore(
        userUid: user.id,
        name: nameTextController.text,
        email: emailTextController.text,
      );

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
