import 'package:get/get.dart';
import 'expenseupdate_controller.dart';

class ExpenseUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseUpdateController>(() => ExpenseUpdateController());
  }
}
