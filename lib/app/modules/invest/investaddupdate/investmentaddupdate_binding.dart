import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/invest/investaddupdate/investmentaddupdate_controller.dart';

class InvestAddUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestmentAddUpdateController>(
        () => InvestmentAddUpdateController());
  }
}
