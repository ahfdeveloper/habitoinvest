import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';

class IncomeAddUpdateBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<IncomeAddUpdateController>(() => IncomeAddUpdateController());
  }
}