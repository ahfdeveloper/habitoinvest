import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_controller.dart';

class ParametersBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ParametersController>(() => ParametersController());
  }
}