import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';

class DividerHorizontal extends StatelessWidget {
  const DividerHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 1.0,
      color: AppColors.stroke,
    );
  }
}
