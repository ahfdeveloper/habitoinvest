import 'package:flutter_masked_text2/flutter_masked_text2.dart';

// Distância padrão entre widgets de um formulário
const SPACEFORMS = 10.0;

// Define o formato da máscara do TextFormField para moeda BRL
final MoneyMaskedTextController moneyValueController = MoneyMaskedTextController(
  leftSymbol: 'R\$ ',
);
