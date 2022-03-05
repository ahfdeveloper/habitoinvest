import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimeIndicatorProgress extends StatelessWidget {
  final double percentageCurrent;
  final double percentageProgress;

  const TimeIndicatorProgress({Key? key, required this.percentageCurrent, required this.percentageProgress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
    //   child: LinearProgressIndicator(
    //     value: percentageCurrent,
    //     color: Colors.black,
    //     backgroundColor: Colors.black12,
    //   ),
    // );

    return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
        child: LinearPercentIndicator(
          trailing: Text('${percentageProgress.toStringAsFixed(0)}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          lineHeight: 7,
          progressColor: Colors.black,
          backgroundColor: Colors.black12,
          animation: true,
          animationDuration: 1500,
          percent: percentageCurrent,
        ));
  }
}
