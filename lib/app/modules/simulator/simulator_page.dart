import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';

class SimulatorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: THEMECOLOR,
        title: Text('Simulador de Investimento'),
      ),

      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              decoration: textFormFieldDecoration1('Valor a ser aplicado mensalmente', 'p.ex. 00.00', false),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              decoration: textFormFieldDecoration1('Taxa de juros anual (%)', 'p.ex. 00.00', false),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              decoration: textFormFieldDecoration1('Prazo em meses', 'p.ex. 60', false),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SPACEFORMS),

            ElevatedButton(
              onPressed: () {  },
              child: Text(
                'SIMULAR',
                textScaleFactor: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

}