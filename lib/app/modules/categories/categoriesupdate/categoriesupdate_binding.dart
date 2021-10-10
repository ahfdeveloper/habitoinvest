import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesupdate/categoriesupdate_controller.dart';

class CategoriesUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesUpdateController>(() => CategoriesUpdateController());
  }
}
