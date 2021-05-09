import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/modules/simulator/components/buttons.dart';

class SimulatorPage extends StatelessWidget{
  final Color _interfaceColor = AppColors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: _interfaceColor,
        title: Text('Simulador de Investimento', style: AppTextStyles.appBarTextLight)
      ),

      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              decoration: textFormFieldDecoration1('Valor a ser aplicado mensalmente', 'p.ex. 00.00', false),
              style: AppTextStyles.generallyTextDarkBody,
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              decoration: textFormFieldDecoration1('Taxa de juros anual (%)', 'p.ex. 00.00', false),
              style: AppTextStyles.generallyTextDarkBody,
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              decoration: textFormFieldDecoration1('Prazo em meses', 'p.ex. 60', false),
              style: AppTextStyles.generallyTextDarkBody,
            ),
            SizedBox(height: SPACEFORMS),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ButtonWidget.transparent(
                label: 'Nova simulação',
                onTap: (){},
              ),
            ),
            
            SizedBox(width: 8.0),

            Expanded(
              child: ButtonWidget.black(
                label: 'SIMULAR',
                onTap: (){},
              ),
            ),

          ],
        ),
      ),
    );
  }

}