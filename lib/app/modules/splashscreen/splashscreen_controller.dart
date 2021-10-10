import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage('habito_invest_app');

  @override
  void onReady() {
    Timer(
      Duration(seconds: 2),
      () => isLogged(),
    );
    super.onReady();
  }

  /* Verifica se já existe usuário logado, se sim navega para a Home senão navega
  para a página de login. */
  void isLogged() {
    if (box.hasData('auth')) {
      UserModel user = UserModel(
          id: box.read('auth')['id'],
          email: box.read('auth')['email'],
          name: box.read('auth')['name'],
          urlimage: box.read('auth')['urlimage']);
      Get.offAllNamed(Routes.HOME, arguments: user);
    } else {
      Get.offAllNamed(Routes.WELCOME);
    }
  }
}
