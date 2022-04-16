import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/utils/app_masks.dart';
import 'projection_controller.dart';
import 'widgets/chart_card_projection.dart';

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
            onPressed: () => Get.defaultDialog(
                titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
                title: 'Despesas não essenciais',
                middleText:
                    'A meta de despesas não essenciais exibida, caso não seja um valor fixo, é calculada com base na renda mensal cadastrada nos parâmetros e na meta em porcentagem definida pelo usuário.\n A projeção apresentada leva em consideração as despesas não marcadas como pagas',
                textConfirm: 'OK',
                buttonColor: AppColors.themeColor,
                confirmTextColor: AppColors.white,
                onConfirm: () {
                  Get.back();
                }),
            icon: Icon(Icons.help, color: AppColors.white),
          ),
        ],
      ),
      body: Obx(
        () => _projectionController.goalsList.isEmpty ||
                _projectionController.goalsList == [] ||
                _projectionController.expenseList.isEmpty ||
                _projectionController.expenseList == [] ||
                _projectionController.parametersList.isEmpty ||
                _projectionController.parametersList == []
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    height: 0.5,
                    color: AppColors.backgroundColor,
                  ),
                  Container(
                    color: AppColors.themeColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(Icons.track_changes, color: AppColors.white, size: 35.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Meta de despesas não essenciais',
                                      style: GoogleFonts.notoSans(color: AppColors.white, fontSize: 14.0, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${moneyFormatter.format(_projectionController.loadGoalExpenses())}',
                                      style: GoogleFonts.notoSans(color: AppColors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.backgroundColor),
                        child: ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return ChartCardProjection(
                              period: Text(
                                dateFormat.format(_projectionController.getPeriod(index + 1).first) +
                                    ' à ' +
                                    dateFormat.format(_projectionController.getPeriod(index + 1).last),
                                style: AppTextStyles.titleCardHome,
                              ),
                              effectiveValue: Text(
                                'Despesas previstas:  ${moneyFormatter.format(_projectionController.loadNotEssencialExpensesFuture(index + 1))}',
                                style: AppTextStyles.textCardProjection,
                              ),
                              hoursValue: Text(
                                'Horas de trabalho: ${_projectionController.loadWorkedHours(index + 1).toStringAsFixed(1)}',
                                style: AppTextStyles.textCardProjection,
                              ),
                              colorChart: AppColors.expenseColor,
                              goalPercent: (_projectionController.notEssencialExpenses.elementAt(index) / _projectionController.goalNotEssentialExpenses),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
