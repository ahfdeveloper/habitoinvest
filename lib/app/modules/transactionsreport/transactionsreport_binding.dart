import 'package:get/get.dart';

import 'transactionsreport_controller.dart';

class TransactionsReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsReportController>(() => TransactionsReportController());
  }
}
