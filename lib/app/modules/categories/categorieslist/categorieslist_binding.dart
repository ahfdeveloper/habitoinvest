import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_controller.dart';

class CategoriesListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesListController>(() => CategoriesListController());
  }
}
