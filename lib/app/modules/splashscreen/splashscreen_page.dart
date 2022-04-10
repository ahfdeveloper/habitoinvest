import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/values/app_images.dart';

// Implementação do SplashScreen do app
class SplashScreenPage extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 5.0),
          height: 350,
          width: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.logo),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
