import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_controller.dart';

class ExpenseListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseListController>(() => ExpenseListController());
  }
}