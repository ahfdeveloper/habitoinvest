import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsDefinitionController extends GetxController {

  static const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

  // Cores dos botões Porcentagem e Valor Fixo
  Rx<Color> buttonBackgroundPercentage = Colors.blue[50].obs;
  Rx<Color> buttonTextPercentage = Colors.blue.obs;
  Rx<Color> buttonBackgroundFixedValue = Colors.blue[50].obs;
  Rx<Color> buttonTextFixedValue = Colors.blue.obs;

  /* Variáveis a serem alteradas dependendo se usuário escolher definir um valor em
    porcentagem ou valor fixo */
  RxString inicioValor = ''.obs;
  RxString fimValor = ''.obs;
  RxString valor = ''.obs;

  
void percentageButtonSelect(){
  buttonBackgroundPercentage.value = Colors.orange;
  buttonTextPercentage.value = white;
  buttonBackgroundFixedValue.value = Colors.blue[50];
  buttonTextFixedValue.value = Colors.blue;
  inicioValor.value = '';
  valor.value = '0';
  fimValor.value = '%';
}


void fixedValueButtonSelect(){
  buttonBackgroundFixedValue.value = Colors.orange;
  buttonTextFixedValue.value = white;
  buttonBackgroundPercentage.value = Colors.blue[50];
  buttonTextPercentage.value = Colors.blue;
  inicioValor.value = 'R\$';
  valor.value = '0';
  fimValor.value = '00';
}


}