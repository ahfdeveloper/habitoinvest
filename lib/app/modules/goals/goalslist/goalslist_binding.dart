import 'package:get/get.dart';
import 'goalslist_controller.dart';

class GoalsListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalsListController>(() => GoalsListController());
  }
}
