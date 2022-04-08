import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/goals/goalswarning/goalswarning_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

import '../../../widgets/app_colors.dart';
import '../../../widgets/app_text_styles.dart';

class GoalsWarningPage extends StatelessWidget {
  final GoalsWarningController _goalsWarningController = GoalsWarningController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Definir Metas Metas', style: AppTextStyles.appBarTextLight),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.themeColor,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('Suas metas ainda não foram definidas'),
              Text('Deseja cadastrar?'),
              ElevatedButton(
                onPressed: () {
                  Get.offAndToNamed(Routes.GOALS, arguments: _goalsWarningController.user);
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
