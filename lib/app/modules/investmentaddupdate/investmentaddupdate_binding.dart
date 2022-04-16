import 'package:get/get.dart';
import 'investmentaddupdate_controller.dart';

class InvestAddUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestmentAddUpdateController>(() => InvestmentAddUpdateController());
  }
}
