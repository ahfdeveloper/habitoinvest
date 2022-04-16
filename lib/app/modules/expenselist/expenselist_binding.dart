import 'package:get/get.dart';
import 'expenselist_controller.dart';

class ExpenseListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseListController>(() => ExpenseListController());
  }
}
