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
