import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../widgets/app_colors.dart';

class TimeIndicatorDescription extends StatelessWidget {
  final int pastDays;
  final int periodDays;
  final double percentageDaysPassed;

  const TimeIndicatorDescription({
    Key? key,
    required this.pastDays,
    required this.periodDays,
    required this.percentageDaysPassed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 15.0, bottom: 15.0),
        child: Row(
          children: [
            Icon(Icons.calendar_month_outlined, color: AppColors.bodyTextPagesColor),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dias passados: $pastDays',
                  style: GoogleFonts.notoSans(fontSize: 11.5, color: AppColors.bodyTextPagesColor),
                ),
                Text(
                  'Dias do período: $periodDays',
                  style: GoogleFonts.notoSans(fontSize: 11.5, color: AppColors.bodyTextPagesColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
