import 'package:get/get.dart';
import 'goalsaddupdate_controller.dart';

class GoalsAddUpdateBinding implements Bindings {
  void dependencies() {
    Get.lazyPut<GoalsAddUpdateController>(() => GoalsAddUpdateController());
  }
}
