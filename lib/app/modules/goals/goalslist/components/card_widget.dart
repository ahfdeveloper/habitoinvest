import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';

class CardWidget extends StatelessWidget {
  final String? goalName;
  final String? goalValue;
  final String? goalUniverse;
  final VoidCallback? onTap;

  const CardWidget({this.goalName, this.goalValue, this.goalUniverse, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: AppColors.grey300)),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            children: [
              Expanded(flex: 1, child: Icon(Icons.monetization_on, color: Colors.grey[700])),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goalName!, textAlign: TextAlign.left, style: AppTextStyles.cardHeadTextGoal),
                    Text(goalValue!, textAlign: TextAlign.left, style: AppTextStyles.cardValueTextGoal),
                    Text(goalUniverse!, textAlign: TextAlign.left, style: AppTextStyles.cardFeatTextGoal),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
