import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';

class ChartHome extends StatelessWidget {
  final Color colorChart;
  final double percentageValue;

  const ChartHome({
    Key? key,
    required this.colorChart,
    required this.percentageValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double chartSize = 90.0;
    return Container(
      height: chartSize,
      width: chartSize,
      child: Stack(
        children: [
          Container(
            height: chartSize,
            width: chartSize,
            child: Stack(
              children: [
                Container(
                  height: chartSize,
                  width: chartSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 12.0,
                    value: percentageValue,
                    backgroundColor: AppColors.grey300,
                    valueColor: AlwaysStoppedAnimation(colorChart),
                  ),
                ),
                Center(child: Text('${(percentageValue * 100).toStringAsFixed(0)}%', style: AppTextStyles.appBarTextDark))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
