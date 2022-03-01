import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

// Distância padrão entre widgets de um formulário
const SPACEFORMS = 10.0;

// Define o formato da máscara do TextFormField para moeda BRL
final MoneyMaskedTextController moneyValueController = MoneyMaskedTextController(
  leftSymbol: 'R\$ ',
);

final MoneyMaskedTextController porcentageValueController = MoneyMaskedTextController(
  rightSymbol: '\%',
  precision: 0,
  decimalSeparator: '',
);

final moneyFormatter = NumberFormat.currency(locale: "pt-br", symbol: "R\$");

final dateFormat = DateFormat('dd/MM/yyyy');
