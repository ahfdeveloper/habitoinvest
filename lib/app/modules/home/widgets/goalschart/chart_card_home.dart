import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_masks.dart';
import '../../../../core/theme/app_colors.dart';
import 'chart_home.dart';

class ChartCard extends StatelessWidget {
  final double percentGoalExpense;
  final double goalValueExpense;
  final double effectiveValueExpense;
  final double hoursValueExpense;
  final double percentGoalInvestment;
  final double goalValueInvestment;
  final double effectiveValueInvestment;

  ChartCard({
    Key? key,
    required this.percentGoalExpense,
    required this.goalValueExpense,
    required this.effectiveValueExpense,
    required this.hoursValueExpense,
    required this.percentGoalInvestment,
    required this.goalValueInvestment,
    required this.effectiveValueInvestment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cornerContainer = 10.0;
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(cornerContainer), topRight: Radius.circular(cornerContainer)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                    child: ChartHome(colorChart: AppColors.expenseColor, percentageValue: percentGoalExpense),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Despesas não essenciais', style: AppTextStyles.titleCardHome),
                        SizedBox(height: 2.0),
                        Row(
                          children: [
                            Icon(Icons.track_changes, color: AppColors.bodyTextPagesColor),
                            Text(' ${moneyFormatter.format(goalValueExpense)}', style: AppTextStyles.bodyTextCardHome),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.payment, color: AppColors.bodyTextPagesColor),
                            Text(' ${moneyFormatter.format(effectiveValueExpense)}', style: AppTextStyles.bodyTextCardHome),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.work_outline, color: AppColors.bodyTextPagesColor),
                            Text(' ${hoursValueExpense.toStringAsFixed(1)}', style: AppTextStyles.bodyTextCardHome),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(cornerContainer), bottomRight: Radius.circular(cornerContainer)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                    child: ChartHome(colorChart: AppColors.investColor, percentageValue: percentGoalInvestment),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Investimentos', style: AppTextStyles.titleCardHome),
                        SizedBox(height: 2.0),
                        Row(
                          children: [
                            Icon(Icons.track_changes, color: AppColors.bodyTextPagesColor),
                            Text(' ${moneyFormatter.format(goalValueInvestment)}', style: AppTextStyles.bodyTextCardHome),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.moving_outlined, color: AppColors.bodyTextPagesColor),
                            Text(' ${moneyFormatter.format(effectiveValueInvestment)}', style: AppTextStyles.bodyTextCardHome),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
