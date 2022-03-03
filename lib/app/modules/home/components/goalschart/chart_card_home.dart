import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/home/components/goalschart/chart_home.dart';

class ChartCard extends StatelessWidget {
  final double percentGoalExpense;
  final Widget goalValueExpense;
  final Widget effectiveValueExpense;
  final Widget hoursValueExpense;
  final double percentGoalInvestment;
  final Widget goalValueInvestment;
  final Widget effectiveValueInvestment;

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
                        Text('Despesas não essenciais', style: AppTextStyles.titleCardProjection),
                        SizedBox(height: 10.0),
                        goalValueExpense,
                        effectiveValueExpense,
                        hoursValueExpense,
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(cornerContainer), bottomRight: Radius.circular(cornerContainer)),
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
                        Text('Investimentos', style: AppTextStyles.titleCardProjection),
                        SizedBox(height: 10.0),
                        goalValueInvestment,
                        effectiveValueInvestment,
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
