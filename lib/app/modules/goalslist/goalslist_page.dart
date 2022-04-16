import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/values/app_constants.dart';
import '../../routes/routes.dart';
import '../goalsupdate/goalsupdate_controller.dart';
import 'goalslist_controller.dart';
import 'widgets/card_widget.dart';

class GoalsListPage extends StatelessWidget {
  final GoalsListController _goalsListController = Get.find<GoalsListController>();
  final GoalsUpdateController _goalsUpdateController = Get.put(GoalsUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
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
                        goalName: 'Gastos não essenciais',
                        goalValue: _goalsListController.goalsList.first.percentageNotEssentialExpenses != 0
                            ? '${_goalsListController.goalsList.first.percentageNotEssentialExpenses}%'
                            : 'R\$ ${_goalsListController.goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2)}',
                        goalUniverse: _goalsListController.goalsList.first.percentageNotEssentialExpenses != 0 ? 'do total das receitas' : 'por período',
                        onTap: () => loadDataCardNotEssentialExpense(),
                      ),
                      SizedBox(height: SPACEFORMS),
                      CardWidget(
                        goalName: 'Investimentos',
                        goalValue: _goalsListController.goalsList.first.percentageInvestiment != 0
                            ? ('${_goalsListController.goalsList.first.percentageInvestiment}\%')
                            : 'R\$ ${_goalsListController.goalsList.first.valueInvestment!.toStringAsFixed(2)}',
                        goalUniverse: _goalsListController.goalsList.first.percentageInvestiment != 0 ? 'do total das receitas' : 'por período',
                        onTap: () => loadDataCardInvestiment(),
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
    _goalsUpdateController.goalId = _goalsListController.goalsList.first.id!;
    _goalsUpdateController.fvalue = _goalsListController.goalsList.first.valueInvestment!.toStringAsFixed(2);
    if (_goalsListController.goalsList.first.valueInvestment != 0) {
      _goalsUpdateController.fixedValueButtonSelect();
    } else {
      _goalsUpdateController.percentageButtonSelect();
    }
    _goalsUpdateController.title = 'Investimentos';
    Get.toNamed(Routes.GOALS_DEFINITION, arguments: _goalsListController.user);
  }

  // Carrefa dados do meta gastos não essenciais para a próxima tela
  loadDataCardNotEssentialExpense() {
    _goalsUpdateController.goalId = _goalsListController.goalsList.first.id!;
    _goalsUpdateController.fvalue = _goalsListController.goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2);
    if (_goalsListController.goalsList.first.valueNotEssentialExpenses != 0) {
      _goalsUpdateController.fixedValueButtonSelect();
    } else {
      _goalsUpdateController.percentageButtonSelect();
    }
    _goalsUpdateController.title = 'Gastos não essenciais';
    Get.toNamed(Routes.GOALS_DEFINITION, arguments: _goalsListController.user);
  }
}
