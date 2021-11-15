import 'package:flutter_masked_text2/flutter_masked_text2.dart';

const SPACEFORMS = 10.0;

final MoneyMaskedTextController moneyValueController =
    MoneyMaskedTextController(
  leftSymbol: 'R\$ ',
  decimalSeparator: ',',
  thousandSeparator: '.',
);
