import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/functions.dart';
import '../../global/constants.dart';

class SimulatorController extends GetxController {
  MoneyMaskedTextController contributionValueController = moneyValueController;
  TextEditingController interestRateController = TextEditingController();

  RxDouble _interestRate = 0.0.obs;
  get interestRate => this._interestRate.value;
  set interestRate(value) => this._interestRate.value = value;

  // Armazena o total dos aportes de acordo com o tempo
  double _contributionValue = 0.0;
  get contributionValue => this._contributionValue;
  set contributionValue(value) => this._contributionValue = value;

  // Armazena total dos aportes em 5 anos
  RxString _contributionFiveYears = ''.obs;
  get contributionFiveYears => this._contributionFiveYears.value;
  set contributionFiveYears(value) => this._contributionFiveYears.value = value;

  // Armazena o total dos aportes + rentabilidade em 5 anos
  RxString _profitabilityFiveYears = ''.obs;
  get profitabilityFiveYears => this._profitabilityFiveYears.value;
  set profitabilityFiveYears(value) => this._profitabilityFiveYears.value = value;

  // Armazena total dos aportes em 10 anos
  RxString _contributionTenYears = ''.obs;
  get contributionTenYears => this._contributionTenYears.value;
  set contributionTenYears(value) => this._contributionTenYears.value = value;

  // Armazena o total dos aportes + rentabilidade em 10 anos
  RxString _profitabilityTenYears = ''.obs;
  get profitabilityTenYears => this._profitabilityTenYears.value;
  set profitabilityTenYears(value) => this._profitabilityTenYears.value = value;

  // Armazena total dos aportes em 20 anos
  RxString _contributionTwentyYears = ''.obs;
  get contributionTwentyYears => this._contributionTwentyYears.value;
  set contributionTwentyYears(value) => this._contributionTwentyYears.value = value;

  // Armazena o total dos aportes + rentabilidade em 20 anos
  RxString _profitabilityTwentyYears = ''.obs;
  get profitabilityTwentyYears => this._profitabilityTwentyYears.value;
  set profitabilityTwentyYears(value) => this._profitabilityTwentyYears.value = value;

  // Armazena total dos aportes em 30 anos
  RxString _contributionThirtyYears = ''.obs;
  get contributionThirtyYears => this._contributionThirtyYears.value;
  set contributionThirtyYears(value) => this._contributionThirtyYears.value = value;

  // Armazena o total dos aportes + rentabilidade em 20 anos
  RxString _profitabilityThirtyYears = ''.obs;
  get profitabilityThirtyYears => this._profitabilityThirtyYears.value;
  set profitabilityThirtyYears(value) => this._profitabilityThirtyYears.value = value;

  // Retorna o valor aportado durante certo período de tempo e o valor atualizado com a rentabilidade
  totalAplication() {
    contributionValue = contributionValueController.numberValue;
    interestRate = double.parse(interestRateController.text);
    double accumulatedValue = 0.0;

    for (int i = 1; i <= 360; i++) {
      accumulatedValue = accumulatedValue + (accumulatedValue * interestRate / 100) + contributionValue;
      if (i == 60) {
        contributionFiveYears = 'Aporte total em 5 anos:  ${moneyFormatter.format(contributionValue * 60)}';
        profitabilityFiveYears = 'Aporte + rentabilidade:  ${moneyFormatter.format(accumulatedValue)}';
      }

      if (i == 120) {
        contributionTenYears = 'Aporte total em 10 anos:  ${moneyFormatter.format(contributionValue * 120)}';
        profitabilityTenYears = 'Aporte + rentabilidade:  ${moneyFormatter.format(accumulatedValue)}';
      }

      if (i == 240) {
        contributionTwentyYears = 'Aporte total em 20 anos:  ${moneyFormatter.format(contributionValue * 240)}';
        profitabilityTwentyYears = 'Aporte + rentabilidade:  ${moneyFormatter.format(accumulatedValue)}';
      }

      if (i == 360) {
        contributionThirtyYears = 'Aporte total em 30 anos:  ${moneyFormatter.format(contributionValue * 360)}';
        profitabilityThirtyYears = 'Aporte + rentabilidade:  ${moneyFormatter.format(accumulatedValue)}';
      }
    }
  }

  // Limpa o formulário para nova simulação
  limpaFormulario() {
    contributionValueController.text = 0.0.toString();
    interestRateController.text = '';
    contributionFiveYears = '';
    contributionTenYears = '';
    contributionTwentyYears = '';
    contributionThirtyYears = '';
    profitabilityFiveYears = '';
    profitabilityTenYears = '';
    profitabilityTwentyYears = '';
    profitabilityThirtyYears = '';
    DisabledFocusNode();
  }
}
