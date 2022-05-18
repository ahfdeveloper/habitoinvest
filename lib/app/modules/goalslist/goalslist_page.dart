import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/core/utils/app_masks.dart';
import 'package:habito_invest_app/app/core/values/app_images.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/values/app_constants.dart';
import '../../routes/routes.dart';
import 'goalslist_controller.dart';
import 'widgets/card_widget.dart';

class GoalsListPage extends GetView<GoalsListController> {
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
          itemCount: controller.goalsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CardWidget(
                        goalLogo: SvgPicture.asset(AppImages.expenseGoal),
                        goalName: 'Gastos não essenciais',
                        goalValue: controller.goalsList.first.percentageNotEssentialExpenses != 0
                            ? '${controller.goalsList.first.percentageNotEssentialExpenses}%'
                            : moneyFormatter.format(controller.goalsList.first.valueNotEssentialExpenses!),
                        goalUniverse: controller.goalsList.first.percentageNotEssentialExpenses != 0 ? 'do total das receitas' : 'por período',
                        onTap: () => loadDataCardNotEssentialExpense(),
                      ),
                      SizedBox(height: SPACEFORMS),
                      CardWidget(
                        goalLogo: SvgPicture.asset(AppImages.investmentGoal),
                        goalName: 'Investimentos',
                        goalValue: controller.goalsList.first.percentageInvestiment != 0
                            ? ('${controller.goalsList.first.percentageInvestiment}\%')
                            : moneyFormatter.format(controller.goalsList.first.valueInvestment!),
                        goalUniverse: controller.goalsList.first.percentageInvestiment != 0 ? 'do total das receitas' : 'por período',
                        onTap: () => loadDataCardInvestiment(),
                      ),
                      SizedBox(height: SPACEFORMS),
                      Align(alignment: Alignment.topLeft, child: Text('*Última atualização: ' + DateFormat('dd/MM/yyyy').format(controller.goalsList.first.date))),
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
    Get.toNamed(Routes.GOALS_DEFINITION, arguments: {
      'user': controller.user,
      'title': 'Investimentos',
      'goalId': controller.goalsList.first.id!,
      'fvalue': controller.goalsList.first.valueInvestment!.toStringAsFixed(2),
      'pvalue': controller.goalsList.first.percentageInvestiment!.toString(),
    });
  }

  // Carrefa dados do meta gastos não essenciais para a próxima tela
  loadDataCardNotEssentialExpense() {
    Get.toNamed(Routes.GOALS_DEFINITION, arguments: {
      'user': controller.user,
      'title': 'Gastos não essenciais',
      'goalId': controller.goalsList.first.id!,
      'fvalue': controller.goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2),
      'pvalue': controller.goalsList.first.percentageNotEssentialExpenses!.toString(),
    });
  }
}
