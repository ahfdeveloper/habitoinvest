import 'package:get/get.dart';

import 'incomelist_controller.dart';

class IncomeListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomeListController>(() => IncomeListController());
  }
}
