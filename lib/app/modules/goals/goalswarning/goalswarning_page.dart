import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/goals/goalsupdate/goalsupdate_controller.dart';
import 'package:habito_invest_app/app/modules/goals/goalswarning/goalswarning_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class GoalsWarningPage extends StatelessWidget {
  final GoalsWarningController _goalsWarningController = GoalsWarningController();
  final GoalsUpdateController _goalsAddUpdateController = Get.put(GoalsUpdateController());

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
              Text('Você não possui metas cadastradas'),
              Text('Deseja cadastrar?'),
              ElevatedButton(
                onPressed: () {
                  _goalsAddUpdateController.pvalue = 00.toString();
                  _goalsAddUpdateController.fvalue = 0.toStringAsFixed(2);
                  _goalsAddUpdateController.percentageButtonSelect();
                  _goalsWarningController.addGoal();
                  Get.offAndToNamed(Routes.GOALS_DEFINITION, arguments: _goalsWarningController.user);
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
