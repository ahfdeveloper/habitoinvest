import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_controller.dart';


class SplashScreenBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}