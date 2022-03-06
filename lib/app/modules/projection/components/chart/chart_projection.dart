import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChartProjection extends StatelessWidget {
  final Color colorChart;
  final double percentageValue;

  const ChartProjection({
    Key? key,
    required this.colorChart,
    required this.percentageValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: CircularPercentIndicator(
              radius: 38,
              lineWidth: 9.0,
              percent: percentageValue >= 1 ? 1 : percentageValue,
              animation: true,
              animationDuration: 1650,
              progressColor: colorChart,
              backgroundColor: AppColors.grey350,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text('${(percentageValue * 100).toStringAsFixed(0)}%', style: AppTextStyles.percentageChartHome),
            ),
          ),
        ],
      ),
    );
  }
}
