import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/goals/goalslist/goalslist_controller.dart';
import 'package:habito_invest_app/app/modules/goals/goalsupdate/goalsupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'components/card_widget.dart';

class GoalsListPage extends StatelessWidget {
  final GoalsListController _goalsListController = Get.find<GoalsListController>();
  final GoalsUpdateController _goalsAddUpdateController = Get.put(GoalsUpdateController());

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
                            ? ('${_goalsListController.goalsList.first.percentageInvestiment}\%')
                            : 'R\$ ${_goalsListController.goalsList.first.valueInvestment!.toStringAsFixed(2)}',
                        goalUniverse: 'do total das receitas',
                        onTap: () => loadDataCardInvestiment(),
                      ),
                      SizedBox(height: SPACEFORMS),
                      CardWidget(
                        goalName: 'Gastos não essenciais',
                        goalValue: _goalsListController.goalsList.first.percentageNotEssentialExpenses != 0
                            ? '${_goalsListController.goalsList.first.percentageNotEssentialExpenses}%'
                            : 'R\$ ${_goalsListController.goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2)}',
                        goalUniverse: 'por período',
                        onTap: () => loadDataCardNotEssentialExpense(),
                      ),
                      SizedBox(height: SPACEFORMS),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('*Última atualização: ' + DateFormat('dd/MM/yyyy').format(_goalsListController.goalsList.first.date))),
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

  // Carrefa dados da meta investimento para a próxima tela
  loadDataCardInvestiment() {
    _goalsAddUpdateController.pvalue = _goalsListController.goalsList.first.percentageInvestiment.toString();
    _goalsAddUpdateController.fvalue = _goalsListController.goalsList.first.valueInvestment!.toStringAsFixed(2);
    _goalsAddUpdateController.goalId = _goalsListController.goalsList.first.id!;
    if (_goalsListController.goalsList.first.valueInvestment != 0) {
      _goalsAddUpdateController.fixedValueButtonSelect();
    } else {
      _goalsAddUpdateController.percentageButtonSelect();
    }
    _goalsAddUpdateController.title = 'Investimentos';
    Get.toNamed(Routes.GOALS_DEFINITION, arguments: _goalsListController.user);
  }

  // Carrefa dados do meta gastos não essenciais para a próxima tela
  loadDataCardNotEssentialExpense() {
    _goalsAddUpdateController.pvalue = _goalsListController.goalsList.first.percentageNotEssentialExpenses.toString();
    _goalsAddUpdateController.fvalue = _goalsListController.goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2);
    _goalsAddUpdateController.goalId = _goalsListController.goalsList.first.id!;
    if (_goalsListController.goalsList.first.valueNotEssentialExpenses != 0) {
      _goalsAddUpdateController.fixedValueButtonSelect();
    } else {
      _goalsAddUpdateController.percentageButtonSelect();
    }
    _goalsAddUpdateController.title = 'Gastos não essenciais';
    Get.toNamed(Routes.GOALS_DEFINITION, arguments: _goalsListController.user);
  }
}
