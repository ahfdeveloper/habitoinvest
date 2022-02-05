// Validação do TextFormField com valores que usa MoneyMaskedTextController
import 'package:flutter/material.dart';

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
List<DateTime> getInitialDateQuery(int dayInitialPeriod) {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  if (day >= dayInitialPeriod && day <= 31) {
    return [DateTime(year, month, dayInitialPeriod), DateTime(year, month + 1, dayInitialPeriod)];
  } else {
    print(DateTime(year, month - 1, day));
    return [DateTime(year, month - 1, dayInitialPeriod), DateTime(year, month, dayInitialPeriod)];
  }
}
