import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';

class LoginBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<LoginController>(() => LoginController());
  }
}