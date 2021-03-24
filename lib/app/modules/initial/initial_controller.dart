import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InitialController extends GetxController {
  final box = GetStorage('habito_invest_app');


  // Verifica se já existe usuário logado
  /* dynamic isLogged(){
    if(box.hasData('auth')){
      UserModel user = UserModel(
        id: box.read('auth')['id'],
        email: box.read('auth')['email'],
        name: box.read('auth')['name'],
        urlimage: box.read('auth')['urlimage']
      );
      return Get.offAllNamed(Routes.HOME, arguments: user);
    } else {
      return Routes.LOGIN;
    }
  } */
}