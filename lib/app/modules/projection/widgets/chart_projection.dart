import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

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
