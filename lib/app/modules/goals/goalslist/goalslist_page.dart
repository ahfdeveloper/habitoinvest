import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/goals/goalsaddupdate/goalsaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/goals/goalslist/goalslist_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/card_widget.dart';

class GoalsListPage extends StatelessWidget {
  final GoalsListController _goalsListController = Get.find<GoalsListController>();
  final GoalsAddUpdateController _goalsAddUpdateController = Get.put(GoalsAddUpdateController());

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
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(2.0),
          itemCount: _goalsListController.goalsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CardWidget(
                        goalName: 'Investimentos',
                        goalValue: _goalsListController.goalsList.first.percentageInvestiment != 0
                            ? ('${_goalsListController.goalsList.first.percentageInvestiment}%')
                            : 'R\$ ${_goalsListController.goalsList.first.valueInvestment!.toStringAsFixed(2)}',
                        goalUniverse: 'do total das receitas',
                        onTap: () {
                          _goalsAddUpdateController.pvalue = _goalsListController.goalsList.first.percentageInvestiment.toString();
                          _goalsAddUpdateController.fvalue = _goalsListController.goalsList.first.valueInvestment!.toStringAsFixed(2);

                          if (_goalsListController.goalsList.first.valueInvestment != 0) {
                            _goalsAddUpdateController.fixedValueButtonSelect();
                          } else {
                            _goalsAddUpdateController.percentageButtonSelect();
                          }

                          _goalsAddUpdateController.title = 'Investimentos';
                          _goalsAddUpdateController.dateUpdate = _goalsListController.goalsList.first.date;
                          Get.toNamed(Routes.DEFINITION_GOALS, arguments: _goalsListController.user);
                        },
                      ),
                      SizedBox(height: SPACEFORMS),

                      ////PAREI AQUI
                      CardWidget(
                        goalName: 'Gastos não essenciais',
                        goalValue: '${_goalsListController.goalsList.first.percentageNotEssentialExpenses}%',
                        goalUniverse: 'por período',
                        onTap: () => Get.toNamed(Routes.DEFINITION_GOALS, arguments: 'Gastos não essenciais'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}