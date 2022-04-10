// FUNÇÕES USADAS EM VÁRIAS PARTES DO APLICATIVO

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_masks.dart';

validatorValue(value) {
  if (value == 'R\$ 0,00') {
    return 'Valor deve ser diferente de zero';
  }
  return null;
}

// Função de validação dos TextFormfields textuais
validator(value) {
  if (value!.isEmpty) {
    return 'Campo obrigatório';
  }
  return null;
}

// Desabilita o foco do TextFormField
class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

// Habilita o foco do TextFormField
class EnabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => true;
}

// Retorna o período a ser considerado para verificar as metas
List<DateTime> getInitialDateQuery({required int dayInitialPeriod}) {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  if (day >= dayInitialPeriod && day <= 31) {
    // retorna dia anterior ao dia de início do período
    return [DateTime(year, month, dayInitialPeriod - 1), DateTime(year, month + 1, dayInitialPeriod)];
  } else {
    // retorna dia posterior ao dia de início do período
    return [DateTime(year, month - 1, dayInitialPeriod - 1), DateTime(year, month, dayInitialPeriod)];
  }
}

// Retorna o período a ser usado na apuração da projeção das metas
List<DateTime> getDateProjectionExpense({required int dayInitialPeriod, required int fowardMonth}) {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  if (day >= dayInitialPeriod && day <= 31) {
    // retorna dia anterior ao dia de início do período
    return [DateTime(year, month + fowardMonth, dayInitialPeriod - 1), DateTime(year, month + 1 + fowardMonth, dayInitialPeriod)];
  } else {
    // retorna dia posterior ao dia de início do período
    return [DateTime(year, month - 1 + fowardMonth, dayInitialPeriod - 1), DateTime(year, month + fowardMonth, dayInitialPeriod)];
  }
}

// Atualizar o controller de valor moeda e retorna para página anterior
void cancel() {
  moneyValueController.updateValue(0.0);
  Get.back();
}
