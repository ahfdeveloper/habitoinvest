import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/projection/components/chart/chart_card_projection.dart';

import 'projection_controller.dart';

class ProjectionPage extends StatelessWidget {
  final ProjectionController _projectionController = Get.find<ProjectionController>();
  final Color interfaceColor = AppColors.themeColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => cancel()),
        backgroundColor: interfaceColor,
        title: Text('Projeção de despesas', style: AppTextStyles.appBarTextLight),
        actions: [
          IconButton(
            onPressed: () => _projectionController.testeData(),
            icon: Icon(Icons.help, color: AppColors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Obx(
          () => Container(
            child: Column(
              children: [
                Text('Meta de despesas não essenciais:', style: GoogleFonts.notoSans(color: AppColors.grey800, fontSize: 15.0, fontWeight: FontWeight.w700)),
                _projectionController.goalsList.isEmpty || _projectionController.goalsList == []
                    ? CircularProgressIndicator()
                    : Text(
                        '${moneyFormatter.format(_projectionController.loadGoalExpenses())}',
                        style: GoogleFonts.notoSans(color: AppColors.grey800, fontSize: 15.0, fontWeight: FontWeight.w600),
                      ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.backgroundColor),
                    child: ListView(
                      children: [
                        SizedBox(height: 15.0),
                        ChartCardProjection(
                          period: (_projectionController.parametersList.isEmpty || _projectionController.parametersList == [])
                              ? CircularProgressIndicator()
                              : Text(
                                  dateFormat.format(_projectionController.getPeriod(1).first) + ' à ' + dateFormat.format(_projectionController.getPeriod(1).last),
                                  style: AppTextStyles.titleCardProjection,
                                ),
                          effectiveValue: (_projectionController.expenseList.isEmpty ||
                                  _projectionController.expenseList == [] ||
                                  _projectionController.parametersList.isEmpty ||
                                  _projectionController.parametersList == [])
                              ? Text('Despesas previstas:  ${moneyFormatter.format(0)}', style: AppTextStyles.textCardProjection)
                              : Text(
                                  'Despesas previstas:  ${moneyFormatter.format(_projectionController.loadNotEssencialExpensesFuture(1))}',
                                  style: AppTextStyles.textCardProjection,
                                ),
                          hoursValue: _projectionController.parametersList.isEmpty || _projectionController.parametersList == []
                              ? Text('Horas de trabalho:  ${0.0}', style: AppTextStyles.textCardProjection)
                              : Text(
                                  'Horas de trabalho: ${_projectionController.loadWorkedHours(1).toStringAsFixed(1)}',
                                  style: AppTextStyles.textCardProjection,
                                ),
                          colorChart: AppColors.expenseColor,
                          goalPercent: _projectionController.expenseList.isEmpty ||
                                  _projectionController.expenseList == [] ||
                                  _projectionController.goalNotEssentialExpenses == 0.0
                              ? 0.0
                              : (_projectionController.notEssencialExpenses.elementAt(0) / _projectionController.goalNotEssentialExpenses),
                        ),
                        SizedBox(height: 10.0),
                        ChartCardProjection(
                          period: (_projectionController.parametersList.isEmpty || _projectionController.parametersList == [])
                              ? CircularProgressIndicator()
                              : Text(
                                  dateFormat.format(_projectionController.getPeriod(2).first) + ' à ' + dateFormat.format(_projectionController.getPeriod(2).last),
                                  style: AppTextStyles.titleCardProjection,
                                ),
                          effectiveValue: (_projectionController.expenseList.isEmpty ||
                                  _projectionController.expenseList == [] ||
                                  _projectionController.parametersList.isEmpty ||
                                  _projectionController.parametersList == [])
                              ? Text('Despesas previstas:  ${moneyFormatter.format(0)}', style: AppTextStyles.textCardProjection)
                              : Text(
                                  'Despesas previstas:  ${moneyFormatter.format(_projectionController.loadNotEssencialExpensesFuture(2))}',
                                  style: AppTextStyles.textCardProjection,
                                ),
                          hoursValue: _projectionController.parametersList.isEmpty || _projectionController.parametersList == []
                              ? Text('Horas de trabalho:  ${0.0}', style: AppTextStyles.textCardProjection)
                              : Text('Horas de trabalho: ${_projectionController.loadWorkedHours(2).toStringAsFixed(1)}', style: AppTextStyles.textCardProjection),
                          colorChart: AppColors.expenseColor,
                          goalPercent: _projectionController.expenseList.isEmpty ||
                                  _projectionController.expenseList == [] ||
                                  _projectionController.goalNotEssentialExpenses == 0.0
                              ? 0.0
                              : (_projectionController.notEssencialExpenses.elementAt(1) / _projectionController.goalNotEssentialExpenses),
                        ),
                        SizedBox(height: 10.0),
                        ChartCardProjection(
                          period: (_projectionController.parametersList.isEmpty || _projectionController.parametersList == [])
                              ? CircularProgressIndicator()
                              : Text(
                                  dateFormat.format(_projectionController.getPeriod(3).first) + ' à ' + dateFormat.format(_projectionController.getPeriod(3).last),
                                  style: AppTextStyles.titleCardProjection,
                                ),
                          effectiveValue: (_projectionController.expenseList.isEmpty ||
                                  _projectionController.expenseList == [] ||
                                  _projectionController.parametersList.isEmpty ||
                                  _projectionController.parametersList == [])
                              ? Text('Despesas previstas:  ${moneyFormatter.format(0)}', style: AppTextStyles.textCardProjection)
                              : Text(
                                  'Despesas previstas:  ${moneyFormatter.format(_projectionController.loadNotEssencialExpensesFuture(3))}',
                                  style: AppTextStyles.textCardProjection,
                                ),
                          hoursValue: _projectionController.parametersList.isEmpty || _projectionController.parametersList == []
                              ? Text('Horas de trabalho:  ${0.0}', style: AppTextStyles.textCardProjection)
                              : Text(
                                  'Horas de trabalho: ${_projectionController.loadWorkedHours(3).toStringAsFixed(1)}',
                                  style: AppTextStyles.textCardProjection,
                                ),
                          colorChart: AppColors.expenseColor,
                          goalPercent: _projectionController.expenseList.isEmpty ||
                                  _projectionController.expenseList == [] ||
                                  _projectionController.goalNotEssentialExpenses == 0.0
                              ? 0.0
                              : (_projectionController.notEssencialExpenses.elementAt(2) / _projectionController.goalNotEssentialExpenses),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
