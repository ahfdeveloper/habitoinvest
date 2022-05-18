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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
            ),
            SizedBox(height: 30.0),
            Obx(
              () => Visibility(
                visible: controller.visible,
                child: Container(
                  color: AppColors.white,
                  child: Table(
                    columnWidths: {0: FractionColumnWidth(0.2)},
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            color: AppColors.grey300,
                            height: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Tempo', style: AppTextStyles.tableSimulatorText),
                                  Text('(anos)', style: AppTextStyles.tableSimulatorText),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.grey300,
                            height: 60,
                            child: Center(
                              child: Text('Total aportado', style: AppTextStyles.tableSimulatorText),
                            ),
                          ),
                          Container(
                            color: AppColors.grey300,
                            height: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Aportado', style: AppTextStyles.tableSimulatorText),
                                  Text('+ rentabilidade', style: AppTextStyles.tableSimulatorText),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            color: AppColors.grey300,
                            height: 50,
                            child: Center(child: Text('5', style: AppTextStyles.tableSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.contributionFiveYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.profitabilityFiveYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            color: AppColors.grey300,
                            height: 50,
                            child: Center(child: Text('10', style: AppTextStyles.tableSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.contributionTenYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.profitabilityTenYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            color: AppColors.grey300,
                            height: 50,
                            child: Center(child: Text('20', style: AppTextStyles.tableSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.contributionTwentyYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.profitabilityTwentyYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            color: AppColors.grey300,
                            height: 50,
                            child: Center(child: Text('30', style: AppTextStyles.tableSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.contributionThirtyYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                          Container(
                            height: 50,
                            child: Center(child: Text(controller.profitabilityThirtyYears, style: AppTextStyles.tableInsideSimulatorText)),
                          ),
                        ],
                      ),
                    ],
                  ),
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
