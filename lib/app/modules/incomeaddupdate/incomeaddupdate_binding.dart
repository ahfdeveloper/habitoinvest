import 'package:get/get.dart';

import 'incomeaddupdate_controller.dart';

class IncomeAddUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomeAddUpdateController>(() => IncomeAddUpdateController());
  }
}
