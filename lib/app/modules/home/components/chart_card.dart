import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/home/components/chart.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget goalValue;
  final String effective;
  final Widget effectiveValue;
  final Color colorChart;

  ChartCard({
    Key? key,
    required this.title,
    required this.effective,
    required this.goalValue,
    required this.effectiveValue,
    required this.colorChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ChartHome(colorChart: colorChart, percentageValue: 0.55),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.appBarTextDark),
                  SizedBox(height: 10.0),
                  goalValue,
                  effectiveValue,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
