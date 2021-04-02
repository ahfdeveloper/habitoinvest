import 'package:flutter/cupertino.dart';
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


  @override
  void onReady() {
    isLogged();
    super.onReady();
  }


  // Verifica se já existe usuário logado
  void isLogged() {
    if(box.hasData('auth')){
      UserModel user = UserModel(
        id: box.read('auth')['id'],
        email: box.read('auth')['email'],
        name: box.read('auth')['name'],
        urlimage: box.read('auth')['urlimage']
      );
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }


  register() async{
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    UserModel user = await loginRepository.createUserWithEmailAndPassword(
      emailTextController.text, 
      passwordTextController.text, 
      nameTextController.text
    );
    
    if (user != null){
      box.write('auth', user);
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }


  void login() async{
    Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
    UserModel user = await loginRepository.signInWithEmailAndPassword(
      emailTextController.text, 
      passwordTextController.text
    );

    if (user != null){
      box.write('auth', user);
      Get.offAllNamed(Routes.HOME, arguments: user);
    }
  }


  void logout(){
    loginRepository.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

}