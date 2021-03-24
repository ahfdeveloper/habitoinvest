import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/initial/initial_controller.dart';


class InitialBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<InitialController>(() => InitialController());
  }
}