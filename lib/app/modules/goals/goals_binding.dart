import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/goals/goals_controller.dart';

class GoalsBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< GoalsController>(() => GoalsController());
  }
}