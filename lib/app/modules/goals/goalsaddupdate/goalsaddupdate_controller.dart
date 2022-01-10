import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';

class GoalsAddUpdateController extends GetxController {
  MoneyMaskedTextController goalFixedValueController = moneyValueController;
  MaskedTextController goalPercentageValueController = MaskedTextController(mask: '00');

  // Recebe a instância do controller de acordo com o formato da meta selecionada
  var controller;

  // Recebe o nome da meta que está sendo cadastrada/editada
  String _title = '';
  String get title => this._title;
  set title(String value) => this._title = value;

  // Cores dos botões Porcentagem e Valor Fixo com seus getters e setters
  Rx<Color> _buttonColorPercentage = AppColors.themeColor.obs;
  get buttonColorPercentage => this._buttonColorPercentage.value;
  set buttonColorPercentage(value) => this._buttonColorPercentage.value = value;

  Rx<Color> _buttonBackgroundColorPercentage = AppColors.transparent.obs;
  get buttonBackgroundColorPercentage => this._buttonBackgroundColorPercentage.value;
  set buttonBackgroundColorPercentage(value) => this._buttonBackgroundColorPercentage.value = value;

  Rx<Color> _buttonColorFixedValue = AppColors.themeColor.obs;
  get buttonColorFixedValue => this._buttonColorFixedValue.value;
  set buttonColorFixedValue(value) => this._buttonColorFixedValue.value = value;

  Rx<Color> _buttonBackgroundColorFixedValue = AppColors.transparent.obs;
  get buttonBackgroundColorFixedValue => this._buttonBackgroundColorFixedValue.value;
  set buttonBackgroundColorFixedValue(value) => this._buttonBackgroundColorFixedValue.value = value;

  RxString _pvalue = ''.obs;
  get pvalue => this._pvalue.value;
  set pvalue(value) => this._pvalue.value = value;

  RxString _fvalue = ''.obs;
  get fvalue => this._fvalue.value;
  set fvalue(value) => this._fvalue.value = value;

  //--
  // Recebe/altera data do cadastro/edição das metas
  DateTime? _dateUpdate;
  get dateUpdate => this._dateUpdate;
  set dateUpdate(value) => this._dateUpdate = value;

  RxString _value = ''.obs;
  get value => this._value.value;
  set value(value) => this._value.value = value;

  //
  // Função chamada quando selecionado o botão para definir valor em porcentagem de meta
  void percentageButtonSelect() {
    this.buttonColorPercentage = AppColors.white;
    this.buttonBackgroundColorPercentage = AppColors.themeColor;
    this.buttonColorFixedValue = AppColors.grey300;
    this.buttonBackgroundColorFixedValue = AppColors.transparent;
    this.controller = goalPercentageValueController;
    this.controller.text = pvalue;
  }

  // Função chamada quando selecionado o botão para definir valor fixo de meta
  void fixedValueButtonSelect() {
    this.buttonColorFixedValue = AppColors.white;
    this.buttonBackgroundColorFixedValue = AppColors.themeColor;
    this.buttonColorPercentage = AppColors.grey300;
    this.buttonBackgroundColorPercentage = AppColors.transparent;
    this.controller = goalFixedValueController;
    this.controller.text = fvalue;
  }
}
