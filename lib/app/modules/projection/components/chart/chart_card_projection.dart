import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/modules/projection/components/chart/chart_projection.dart';

class ChartCardProjection extends StatelessWidget {
  final double goalPercent;
  final Widget period;
  final Widget effectiveValue;
  final Widget hoursValue;
  final Color colorChart;

  ChartCardProjection({
    Key? key,
    required this.goalPercent,
    required this.period,
    required this.effectiveValue,
    required this.hoursValue,
    required this.colorChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.grey300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ChartProjection(colorChart: colorChart, percentageValue: goalPercent),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    period,
                    effectiveValue,
                    hoursValue,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
