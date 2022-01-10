import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:intl/intl.dart';

class SimulatorController extends GetxController {
  final formatter = NumberFormat.currency(locale: "pt-br", symbol: "R\$");

  MoneyMaskedTextController contributionValueController = moneyValueController;
  TextEditingController interestRateController = TextEditingController();
  TextEditingController aplicationDeadlineController = TextEditingController();

  RxDouble _contributionValue = 0.0.obs;
  get contributionValue => this._contributionValue.value;
  set contributionValue(value) => this._contributionValue.value = value;

  RxDouble _interestRate = 0.0.obs;
  get interestRate => this._interestRate.value;
  set interestRate(value) => this._interestRate.value = value;

  RxInt _aplicationDeadline = 0.obs;
  get aplicationDeadline => this._aplicationDeadline.value;
  set aplicationDeadline(value) => this._aplicationDeadline.value = value;

  RxString _totalContribution = ''.obs;
  get totalContribution => this._totalContribution.value;
  set totalContribution(value) => this._totalContribution.value = value;

  RxString _totalWithProfitability = ''.obs;
  get totalWithProfitability => this._totalWithProfitability.value;
  set totalWithProfitability(value) => this._totalWithProfitability.value = value;

  RxString _resultSimulation1 = ''.obs;
  get resultSimulation1 => this._resultSimulation1.value;
  set resultSimulation1(value) => this._resultSimulation1.value = value;

  RxString _resultSimulation2 = ''.obs;
  get resultSimulation2 => this._resultSimulation2.value;
  set resultSimulation2(value) => this._resultSimulation2.value = value;

  // Retorna o valor aportado durante certo período de tempo e o valor atualizado com a rentabilidade
  totalAplication() {
    contributionValue = contributionValueController.numberValue;
    interestRate = double.parse(interestRateController.text);
    aplicationDeadline = int.parse(aplicationDeadlineController.text);

    double accumulatedValue = 0.0;
    for (int i = 0; i < aplicationDeadline; i++) {
      accumulatedValue = accumulatedValue + (accumulatedValue * interestRate / 100) + contributionValue;
    }

    totalContribution = formatter.format(contributionValue * aplicationDeadline);
    totalWithProfitability = formatter.format(accumulatedValue);
    resultSimulation1 = 'Valor total aportado:  $totalContribution';
    resultSimulation2 = 'Aporte + rentabilidade:  $totalWithProfitability';
  }

  // Limpa o formulário para nova simulação
  limpaFormulario() {
    contributionValueController.text = 0.0.toString();
    interestRateController.text = '';
    aplicationDeadlineController.text = '';
    totalContribution = '';
    totalWithProfitability = '';
    resultSimulation1 = '';
    resultSimulation2 = '';
    DisabledFocusNode();
  }
}
