import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';

class AppSnackbar {
  static snackarStyle({required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black45,
      colorText: AppColors.white,
      icon: Icon(Icons.info_outline_rounded),
    );
  }
}
