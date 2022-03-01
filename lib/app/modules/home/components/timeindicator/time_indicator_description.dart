import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dias passados: $pastDays',
                    style: TextStyle(fontSize: 11.0),
                  ),
                  Text(
                    'Dias do período: $periodDays',
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${percentageDaysPassed.toStringAsFixed(0)}%', textAlign: TextAlign.end),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
