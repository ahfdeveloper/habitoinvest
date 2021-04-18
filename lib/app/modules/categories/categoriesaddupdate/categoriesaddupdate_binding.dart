import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_controller.dart';

class CategoriesAddUpdateBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CategoriesAddUpdateController>(() => CategoriesAddUpdateController());
  }
}