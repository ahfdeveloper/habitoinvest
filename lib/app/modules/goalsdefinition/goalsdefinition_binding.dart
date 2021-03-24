import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_controller.dart';

class GoalsDefinitionBinding implements Bindings {
void dependencies() {
  Get.lazyPut<GoalsDefinitionController>(() => GoalsDefinitionController());
  }
}