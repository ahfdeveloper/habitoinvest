import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/simulator/components/buttons.dart';
import 'package:habito_invest_app/app/modules/simulator/simulator_controller.dart';

class SimulatorPage extends StatelessWidget {
  final SimulatorController _simulatorController = SimulatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.themeColor,
          title: Text('Simulador de Investimento', style: AppTextStyles.appBarTextLight)),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            SizedBox(height: SPACEFORMS * 2),
            TextFormField(
              controller: _simulatorController.contributionValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor a ser aplicado mensalmente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _simulatorController.interestRateController,
              decoration: InputDecoration(
                labelText: 'Taxa de juros mensal',
                hintText: 'p.ex. 00.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          _simulatorController.contributionFiveYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _simulatorController.profitabilityFiveYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                    Row(
                      children: [
                        Text(
                          _simulatorController.contributionTenYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _simulatorController.profitabilityTenYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                    Row(
                      children: [
                        Text(
                          _simulatorController.contributionTwentyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _simulatorController.profitabilityTwentyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                    Row(
                      children: [
                        Text(
                          _simulatorController.contributionThirtyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _simulatorController.profitabilityThirtyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                  ],
                ),
              ),
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
                onTap: () => _simulatorController.limpaFormulario(),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: ButtonWidget.black(
                label: 'SIMULAR',
                onTap: () => _simulatorController.totalAplication(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
