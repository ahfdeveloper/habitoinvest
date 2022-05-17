import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/values/app_constants.dart';
import 'simulator_controller.dart';
import 'widgets/buttons.dart';

class SimulatorPage extends GetView<SimulatorController> {
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
              controller: controller.contributionValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor a ser aplicado mensalmente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controller.interestRateController,
              decoration: InputDecoration(
                labelText: 'Taxa de juros mensal',
                hintText: 'p.ex. 00.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.contributionFiveYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          controller.profitabilityFiveYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                    Row(
                      children: [
                        Text(
                          controller.contributionTenYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          controller.profitabilityTenYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                    Row(
                      children: [
                        Text(
                          controller.contributionTwentyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          controller.profitabilityTwentyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    SizedBox(height: SPACEFORMS),
                    Row(
                      children: [
                        Text(
                          controller.contributionThirtyYears,
                          style: AppTextStyles.appBarTextDark,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          controller.profitabilityThirtyYears,
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
                onTap: () => controller.limpaFormulario(),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: ButtonWidget.black(
                label: 'SIMULAR',
                onTap: () => controller.totalAplication(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
