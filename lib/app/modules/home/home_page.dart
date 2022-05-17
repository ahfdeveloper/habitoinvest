import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/utils/app_masks.dart';
import '../../routes/routes.dart';
import 'home_controller.dart';
import 'widgets/buttonfunctions/button_function.dart';
import 'widgets/drawer/drawer.dart';
import 'widgets/goalschart/chart_card_home.dart';
import 'widgets/timeindicator/timeindicator_card.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.white),
            centerTitle: true,
            shadowColor: AppColors.backgroundColor,
            backgroundColor: AppColors.themeColor,
            elevation: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Olá ${controller.user!.name}', style: AppTextStyles.appBarTextLight),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.PARAMETERS, arguments: {
                    'user': controller.user,
                    'dropdownDay': controller.parametersList.first.dayInitialPeriod,
                    'salaryTextFormController': controller.parametersList.first.salary!.toStringAsFixed(2),
                    'workedHoursFormController': TextEditingController(text: controller.parametersList.first.workedHours.toString()),
                  });
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          drawer: DrawerHome(),
          body: controller.goalsList.isEmpty ||
                  controller.goalsList == [] ||
                  controller.parametersList.isEmpty ||
                  controller.parametersList == [] ||
                  controller.accountList.isEmpty ||
                  controller.accountList == []
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.backgroundColor),
                        child: ListView(
                          children: [
                            Container(
                              color: AppColors.themeColor,
                              child: Column(
                                children: [
                                  Container(
                                    height: 0.5,
                                    color: AppColors.backgroundColor,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0, top: 14.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Meu Saldo',
                                                  style: GoogleFonts.notoSans(color: AppColors.white, fontSize: 15.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${moneyFormatter.format(controller.accountList.first.balance!)}',
                                                  style: GoogleFonts.notoSans(color: AppColors.white, fontSize: 19.0, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(right: 15.0, top: 2.0),
                                              height: 38,
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(AppColors.transparent),
                                                    shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                    ),
                                                    side: MaterialStateProperty.all(BorderSide(color: AppColors.white))),
                                                onPressed: () => Get.toNamed(Routes.PROJECTION, arguments: {'user': controller.user}),
                                                child: Text(
                                                  'Projeção de despesas',
                                                  style: GoogleFonts.notoSans(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 13.5,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  color: AppColors.themeColor,
                                ),
                                Align(
                                  alignment: Alignment(0, 0.5),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        ChartCard(
                                          // Parâmetros gráfico de despesas
                                          goalValueExpense: controller.loadGoalExpenses(),
                                          effectiveValueExpense: controller.loadNotEssencialExpensesCurrent(),
                                          hoursValueExpense: controller.loadWorkedHours(),
                                          percentGoalExpense: controller.goalNotEssentialExpenses == 0
                                              ? 0
                                              : (controller.totalNotEssencialExpenses / controller.goalNotEssentialExpenses),
                                          // Parâmetros gráfico de investimento
                                          goalValueInvestment: controller.loadGoalInvestiment(),
                                          effectiveValueInvestment: controller.loadInvestmensCurrent(),
                                          percentGoalInvestment: controller.goalInvestiment == 0 ? 0 : (controller.totalInvestments / controller.goalInvestiment),
                                        ),
                                        TimeIndicatorCard(
                                          percentageCurrent: controller.percentagePeriodCurrent(),
                                          percentageDaysPassed: controller.percentagePeriodCurrent() * 100,
                                          percentageProgress: controller.percentagePeriodCurrent() * 100,
                                          pastDays: controller.periodIndicator(DateTime.now()),
                                          periodDays: controller.periodIndicator(
                                            getInitialDateQuery(dayInitialPeriod: controller.parametersList.first.dayInitialPeriod! - 1).last,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 10.0),
                              crossAxisSpacing: 10,
                              childAspectRatio: 2.3,
                              children: [
                                Container(
                                  //height: 75.0,
                                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Maiores despesas não essenciais nos últimos 6 meses',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.notoSans(fontSize: 11.0, color: AppColors.bodyTextPagesColor),
                                        ),
                                        Text('Lazer', style: GoogleFonts.notoSans(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.bodyTextPagesColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 69.0,
                                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Total Investido',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.notoSans(fontSize: 11.0, color: AppColors.bodyTextPagesColor),
                                          ),
                                        ),
                                        Text(''),
                                        Text('R\$5.560,00',
                                            style: GoogleFonts.notoSans(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.bodyTextPagesColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 10.0),
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.82,
                              children: [
                                ButtonFunction(
                                  icon: Icons.monetization_on,
                                  colorButton: AppColors.incomeColor,
                                  label: 'Receitas',
                                  onTap: () => Get.toNamed(Routes.INCOME_LIST, arguments: {'user': controller.user}),
                                  onPressed: () async {
                                    moneyValueController.updateValue(0.0);
                                    Get.toNamed(
                                      Routes.INCOME_ADDUPDATE,
                                      arguments: {'user': controller.user, 'addEditFlag': 'NEW'},
                                    );
                                  },
                                ),
                                //
                                ButtonFunction(
                                  icon: Icons.payment,
                                  colorButton: AppColors.expenseColor,
                                  label: 'Despesas',
                                  onTap: () => Get.toNamed(Routes.EXPENSE_LIST, arguments: {'user': controller.user}),
                                  onPressed: () {
                                    moneyValueController.updateValue(0.0);
                                    Get.toNamed(Routes.EXPENSE_ADD, arguments: {'user': controller.user});
                                  },
                                ),
                                //
                                ButtonFunction(
                                  icon: Icons.moving_outlined,
                                  colorButton: AppColors.investColor,
                                  label: 'Investimentos',
                                  onTap: () => Get.toNamed(Routes.INVESTMENT_LIST, arguments: {'user': controller.user}),
                                  onPressed: () {
                                    moneyValueController.updateValue(0.0);
                                    Get.toNamed(Routes.INVESTMENT_ADDUPDATE, arguments: {'user': controller.user, 'addEditFlag': 'NEW'});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
