import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_controller.dart';

// Implementação do SplashScreen do app
class SplashScreenPage extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: Container(
        margin: EdgeInsets.all(80.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/moeda.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
