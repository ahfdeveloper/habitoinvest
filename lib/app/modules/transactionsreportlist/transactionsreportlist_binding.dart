import 'package:get/get.dart';

import 'transactionsreportlist_controller.dart';

class TransactionsReportListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsReportListController>(() => TransactionsReportListController());
  }
}
