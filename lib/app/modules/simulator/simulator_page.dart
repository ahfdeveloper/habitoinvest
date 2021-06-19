import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/modules/simulator/components/buttons.dart';
import 'package:habito_invest_app/app/modules/simulator/simulator_controller.dart';

class SimulatorPage extends StatelessWidget {
  final SimulatorController _controller = SimulatorController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColors.themeColor,
        title: Text('Simulador de Investimento', style: AppTextStyles.appBarTextLight)),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _controller.contributionValueController,
              decoration: textFormFieldDecoration1('Valor a ser aplicado mensalmente', '', false),
              style: AppTextStyles.generallyTextDarkBody,
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _controller.interestRateController,
              decoration: textFormFieldDecoration1('Taxa de juros mensal', 'p.ex. 00.00', false),
              style: AppTextStyles.generallyTextDarkBody,
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: _controller.aplicationDeadlineController,
              decoration: textFormFieldDecoration1('Prazo em meses', 'p.ex. 60', false),
              style: AppTextStyles.generallyTextDarkBody,
            ),
            SizedBox(height: 30.0),
            
            Container(
              child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      Text(_controller.resultSimulation1, style: AppTextStyles.appBarTextDark),
                      Text(_controller.resultSimulation2, style: AppTextStyles.appBarNumberSaldo),  
                    ],
                  ),
                  Row(
                    children: [
                      Text(_controller.resultSimulation3, style: AppTextStyles.appBarTextDark),
                      Text(_controller.resultSimulation4, style: AppTextStyles.appBarNumberSaldo),  
                    ],
                  ),
                  
                ],
              )),
            ),      
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
                onTap: () => _controller.limpaFormulario(),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: ButtonWidget.black(
                label: 'SIMULAR',
                onTap: () => _controller.totalAplication(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
