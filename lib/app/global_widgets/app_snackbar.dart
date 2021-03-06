import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/app_colors.dart';

class AppSnackbar {
  static snackarStyle({required String title, required String message}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(milliseconds: 1200),
      backgroundColor: Colors.black87,
      colorText: AppColors.white,
      icon: Icon(Icons.info_outline_rounded, color: AppColors.white),
    );
  }
}
