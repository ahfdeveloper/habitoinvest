import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';

class GoalsDefinitionController extends GetxController {
  final String _title = Get.arguments;

  get title => this._title;

  static const MaterialColor grey = const MaterialColor(
    0xBDBDBDBD,
    const <int, Color>{}
  );

  // controller do TextEditing do valor da meta a ser definida
  final TextEditingController valueTextController = TextEditingController();

  // Cores dos botões Porcentagem e Valor Fixo
  Rx<Color> _buttonColorPercentage = INCOMECOLOR.obs;
  Rx<Color> _buttonColorFixedValue = AppColors.themeColor.obs;
  
  /* Variáveis a serem alteradas dependendo se usuário escolher definir um valor em
    porcentagem ou valor fixo */
  RxString _inicioValor = ''.obs;
  RxString _fimValor = ''.obs;
  RxString _valor = ''.obs;

  get buttonColorPercentage => this._buttonColorPercentage.value;
  set buttonColorPercentage(value) => this._buttonColorPercentage.value = value;
  get buttonColorFixedValue => this._buttonColorFixedValue.value;
  set buttonColorFixedValue(value) => this._buttonColorFixedValue.value = value;
  get inicioValor => this._inicioValor.value;
  set inicioValor(value) => this._inicioValor.value = value;
  get fimValor => this._fimValor.value;
  set fimValor(value) => this._fimValor.value = value;
  get valor => this._valor.value;
  set valor(value) => this._valor.value = value;
  
  void percentageButtonSelect(){
    this.buttonColorPercentage = Colors.orange;
    this.buttonColorFixedValue = grey;
    this.inicioValor = '';
    this.valor = '0';
    this.fimValor = '%';
  }


  void fixedValueButtonSelect(){
    this.buttonColorFixedValue = Colors.orange;
    this.buttonColorPercentage = grey;
    this.inicioValor = 'R\$';
    this.valor = '0';
    this.fimValor = '00';
  }

}