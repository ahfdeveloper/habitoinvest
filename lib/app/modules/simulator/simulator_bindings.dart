import 'package:get/get.dart';
import 'simulator_controller.dart';

class SimulatorBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimulatorController>(() => SimulatorController());
  }
}
