import 'package:get/get.dart';

class ParametersController extends GetxController{
  final RxString _dropdownDayType = 'Dia fixo'.obs;
  final Rx<int> _dropdownDay = 1.obs;

  get dropdownDayType => this._dropdownDayType.value;
  set dropdownDayType(value) => this._dropdownDayType.value = value;

  get dropdownDay => this._dropdownDay.value;
  set dropdownDay(value) => this._dropdownDay.value = value;

  


}