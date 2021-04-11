import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_controller.dart';

class ExpenseAddUpdateBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ExpenseAddUpdateController>(() => ExpenseAddUpdateController());
  }
}