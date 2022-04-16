import 'package:get/get.dart';
import 'projection_controller.dart';

class ProjectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectionController>(() => ProjectionController());
  }
}
