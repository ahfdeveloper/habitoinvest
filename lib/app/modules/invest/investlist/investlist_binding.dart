import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/invest/investlist/investlist_controller.dart';

class InvestListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvestListController>(() => InvestListController());
  }
}