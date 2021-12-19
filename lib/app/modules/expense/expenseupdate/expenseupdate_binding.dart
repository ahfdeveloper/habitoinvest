import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/expense/expenseupdate/expenseupdate_controller.dart';

class ExpenseUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseUpdateController>(() => ExpenseUpdateController());
  }
}
