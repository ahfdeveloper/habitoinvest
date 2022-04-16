import 'package:get/get.dart';
import 'goalswarning_controller.dart';

class GoalsWarningBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalsWarningController>(() => GoalsWarningController());
  }
}
