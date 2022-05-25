import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global_widgets/divider_horizontal.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CardWidget extends StatelessWidget {
  final String goalName;
  final String goalValue;
  final String goalUniverse;
  final Widget goalLogo;
  final VoidCallback? onTap;

  const CardWidget({required this.goalName, required this.goalValue, required this.goalUniverse, required this.goalLogo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: AppColors.grey300)),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(goalName, textAlign: TextAlign.left, style: AppTextStyles.cardHeadTextGoal),
            ),
            DividerHorizontal(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: goalLogo,
                  ),
                ),
                Expanded(
                  child: Center(child: Text(goalValue, textAlign: TextAlign.left, style: AppTextStyles.cardValueTextGoal)),
                ),
              ],
            ),
            //DividerHorizontal(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(goalUniverse, textAlign: TextAlign.left, style: AppTextStyles.cardFeatTextGoal),
            ),
          ],
        ),
      ),
    );
  }
}
