import 'package:get/get.dart';
import 'goalsupdate_controller.dart';

class GoalsUpdateBinding implements Bindings {
  void dependencies() {
    Get.lazyPut<GoalsUpdateController>(() => GoalsUpdateController());
  }
}
