import 'package:get/get.dart';
import 'categoriesaddupdate_controller.dart';

class CategoriesAddUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesAddUpdateController>(() => CategoriesAddUpdateController());
  }
}
