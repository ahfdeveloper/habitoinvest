import 'package:flutter/material.dart';

class TimeIndicatorProgress extends StatelessWidget {
  final double percentageCurrent;

  const TimeIndicatorProgress({Key? key, required this.percentageCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
      child: LinearProgressIndicator(
        value: percentageCurrent,
        color: Colors.black,
        backgroundColor: Colors.black12,
      ),
    );
  }
}
