import 'package:get/get.dart';
import 'categorieslist_controller.dart';

class CategoriesListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesListController>(() => CategoriesListController());
  }
}
