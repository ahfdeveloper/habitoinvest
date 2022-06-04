import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/routes.dart';
import 'goalswarning_controller.dart';

class GoalsWarningPage extends GetView<GoalsWarningController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Definir Metas', style: AppTextStyles.appBarTextLight),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.themeColor,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'Suas metas ainda não foram definidas',
                  style: AppTextStyles.textGoalWarning,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Efetue o cadastro',
                  style: AppTextStyles.textGoalWarning,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.0),
                ElevatedButton(
                  child: Text('Cadastrar', style: TextStyle(fontSize: 20.0)),
                  onPressed: () => Get.offAndToNamed(Routes.GOALS, arguments: {'user': controller.user}),
                  style: ElevatedButton.styleFrom(primary: AppColors.themeColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
