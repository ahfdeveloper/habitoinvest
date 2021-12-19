import 'package:get/get.dart';
import 'expenseadd_controller.dart';

class ExpenseAddBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseAddController>(() => ExpenseAddController());
  }
}
