import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SimulatorController extends GetxController {
  final formatter = NumberFormat.currency(locale: "pt-br", symbol: "R\$");

  final MoneyMaskedTextController contributionValueController =
      MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
  );
  final MoneyMaskedTextController interestRateController =
      MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    rightSymbol: ' %',
  );
  final TextEditingController aplicationDeadlineController =
      TextEditingController();

  RxDouble _contributionValue = 0.0.obs;
  RxDouble _interestRate = 0.0.obs;
  RxInt _aplicationDeadline = 0.obs;
  RxString _totalContribution = ''.obs;
  RxString _totalWithProfitability = ''.obs;

  RxString _resultSimulation1 = ''.obs;
  RxString _resultSimulation2 = ''.obs;
  RxString _resultSimulation3 = ''.obs;
  RxString _resultSimulation4 = ''.obs;

  get contributionValue => this._contributionValue.value;
  set contributionValue(value) => this._contributionValue.value = value;
  get interestRate => this._interestRate.value;
  set interestRate(value) => this._interestRate.value = value;
  get aplicationDeadline => this._aplicationDeadline.value;
  set aplicationDeadline(value) => this._aplicationDeadline.value = value;
  get totalContribution => this._totalContribution.value;
  set totalContribution(value) => this._totalContribution.value = value;
  get totalWithProfitability => this._totalWithProfitability.value;
  set totalWithProfitability(value) =>
      this._totalWithProfitability.value = value;

  get resultSimulation1 => this._resultSimulation1.value;
  set resultSimulation1(value) => this._resultSimulation1.value = value;
  get resultSimulation2 => this._resultSimulation2.value;
  set resultSimulation2(value) => this._resultSimulation2.value = value;
  get resultSimulation3 => this._resultSimulation3.value;
  set resultSimulation3(value) => this._resultSimulation3.value = value;
  get resultSimulation4 => this._resultSimulation4.value;
  set resultSimulation4(value) => this._resultSimulation4.value = value;

  // Retorna o valor aportado durante certo período de tempo e o valor atualizado com a rentabilidade
  totalAplication() {
    contributionValue = contributionValueController.numberValue;
    interestRate = interestRateController.numberValue;
    aplicationDeadline = int.parse(aplicationDeadlineController.text);

    double accumulatedValue = 0.0;
    for (int i = 0; i < aplicationDeadline; i++) {
      accumulatedValue = accumulatedValue +
          (accumulatedValue * interestRate / 100) +
          contributionValue;
    }

    totalContribution =
        formatter.format(contributionValue * aplicationDeadline);
    totalWithProfitability = formatter.format(accumulatedValue);

    resultSimulation1 = 'Valor total aportado: ';
    resultSimulation2 = '$totalContribution';
    resultSimulation3 = 'Aporte + rentabilidade: ';
    resultSimulation4 = '$totalWithProfitability';
  }

  // Limpa o formulário para nova simulação
  limpaFormulario() {
    contributionValueController.text = 0.0.toString();
    interestRateController.text = 0.0.toString();
    aplicationDeadlineController.text = '';
    totalContribution = '';
    totalWithProfitability = '';
    resultSimulation1 = '';
    resultSimulation2 = '';
    resultSimulation3 = '';
    resultSimulation4 = '';
    AlwaysDisabledFocusNode();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
