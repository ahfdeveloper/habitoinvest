// Define o formato da máscara do TextFormField para moeda BRL
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

final MoneyMaskedTextController moneyValueController = MoneyMaskedTextController(
  leftSymbol: 'R\$ ',
);

// Máscara para o campo de meta de investimento e despesa essencial em porcentagem
final MoneyMaskedTextController porcentageValueController = MoneyMaskedTextController(
  rightSymbol: '\%',
  precision: 0,
  decimalSeparator: '',
);

// Formatação para formato moeda BRL
final moneyFormatter = NumberFormat.currency(locale: "pt-br", symbol: "R\$");

// Formato data padrão brasileiro
final dateFormat = DateFormat('dd/MM/yyyy');
