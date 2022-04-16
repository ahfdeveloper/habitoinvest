import 'package:get/get.dart';
import 'investmentlist_controller.dart';

class InvestmentListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestmentListController>(() => InvestmentListController());
  }
}
