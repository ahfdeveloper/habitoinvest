import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_controller.dart';

class IncomeListBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<IncomeListController>(() => IncomeListController());
  }
}