import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/simulator/simulator_controller.dart';

class SimulatorBindings implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SimulatorController>(() => SimulatorController());
  }
}