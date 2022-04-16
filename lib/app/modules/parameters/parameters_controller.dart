import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../core/utils/app_masks.dart';
import '../../data/model/parameters_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/parameters_repository.dart';

class ParametersController extends GetxController {
  final UserModel? user = Get.arguments;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final ParametersRepository _parametersRepository = ParametersRepository();

  // Máscara para digitação do salário
  MoneyMaskedTextController salaryTextFormController = moneyValueController;

  // Controller da quantidade de horas trabalhada
  TextEditingController workedHoursFormController = TextEditingController();

  // Lista que guarda os parâmetros do usuário
  Rx<List<ParametersModel>> _parametersList = Rx<List<ParametersModel>>([]);
  List<ParametersModel> get parametersList => _parametersList.value;
  set parametersList(value) => _parametersList.value = value;

  // Variável que recebe o dia do mês selecionado pelo usuário como início do período de mensuração das transações
  Rx<int> _dropdownDay = 1.obs;
  get dropdownDay => this._dropdownDay.value;
  set dropdownDay(value) => this._dropdownDay.value = value;

  // Lista que guarda os dias do mês
  List<int> _daysMonth = [];
  List<int> get daysMonth => this._daysMonth;
  set daysMonth(List<int> value) => this._daysMonth = value;

  @override
  void onInit() {
    _parametersList.bindStream(_parametersRepository.getAllParameters(userUid: user!.id));
    createListDays();
    super.onInit();
  }

  // Cria lista com os dias do mês que é carregado no dropdown
  List<int> createListDays() {
    for (int i = 1; i <= 31; i++) {
      daysMonth.add(i);
    }
    return daysMonth;
  }

  // Atualiza os parametros do usuário
  Future<void> updateParameter() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    _parametersRepository.updateParameter(
      userUid: user!.id,
      parDate: DateTime.now(),
      parDayInitialPeriod: dropdownDay,
      parSalary: salaryTextFormController.numberValue,
      parWorkeHours: int.parse(workedHoursFormController.text),
      parUid: _parametersList.value.first.id!,
    );
    moneyValueController.updateValue(0.0);
    Get.back();
  }
}
