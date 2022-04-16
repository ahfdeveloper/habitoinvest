import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import 'timeindicator_description.dart';
import 'timeindicator_progress.dart';

class TimeIndicatorCard extends StatelessWidget {
  final double percentageCurrent;
  final double percentageProgress;
  final double percentageDaysPassed;
  final int pastDays;
  final int periodDays;

  TimeIndicatorCard({
    Key? key,
    required this.percentageCurrent,
    required this.percentageDaysPassed,
    required this.percentageProgress,
    required this.pastDays,
    required this.periodDays,
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(cornerContainer), bottomRight: Radius.circular(cornerContainer)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Período de apuração',
                          style: GoogleFonts.notoSans(fontSize: 13.0, color: AppColors.bodyTextPagesColor),
                        ),
                      ],
                    ),
                  ),
                  TimeIndicatorProgress(percentageCurrent: percentageCurrent, percentageProgress: percentageProgress),
                  TimeIndicatorDescription(pastDays: pastDays, periodDays: periodDays, percentageDaysPassed: percentageDaysPassed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
