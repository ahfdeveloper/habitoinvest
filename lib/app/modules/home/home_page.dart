import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/home/components/timeindicator/time_indicator_description.dart';
import 'package:habito_invest_app/app/modules/home/components/timeindicator/time_indicator_progress.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/drawer/drawer.dart';
import 'components/goalschart/chart_card_home.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
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
              Text('Olá ${_homeController.user!.name}', style: AppTextStyles.appBarTextLight),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.PARAMETERS, arguments: _homeController.user),
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        drawer: DrawerHome(),
        //bottomNavigationBar: NavBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Expanded(
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
                                      padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Meu Saldo',
                                            style: GoogleFonts.notoSans(color: AppColors.white, fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () {
                                              if (_homeController.accountList.isEmpty || _homeController.accountList == []) {
                                                return CircularProgressIndicator();
                                              } else {
                                                return Text(
                                                  '${moneyFormatter.format(_homeController.accountList.first.balance!)}',
                                                  style: GoogleFonts.notoSans(color: AppColors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                                                );
                                              }
                                            },
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
                                        padding: EdgeInsets.only(right: 15.0),
                                        height: 36,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(AppColors.transparent),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                              ),
                                              side: MaterialStateProperty.all(BorderSide(color: AppColors.white))),
                                          onPressed: () => Get.toNamed(Routes.PROJECTION, arguments: _homeController.user),
                                          child: Text(
                                            'Projeção de despesas',
                                            style: GoogleFonts.notoSans(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 13.0,
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
                            SizedBox(height: 10.0),
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
                                    goalValueExpense: _homeController.goalsList.isEmpty || _homeController.goalsList == []
                                        ? CircularProgressIndicator()
                                        : Text('Meta:  ${moneyFormatter.format(_homeController.loadGoalExpenses())}'),
                                    effectiveValueExpense: (_homeController.expenseList.isEmpty || _homeController.expenseList == [])
                                        ? Text('Despesas:  ${moneyFormatter.format(0)}')
                                        : Text('Despesas:  ${moneyFormatter.format(_homeController.loadNotEssencialExpensesCurrent())}'),
                                    hoursValueExpense: _homeController.parametersList.isEmpty || _homeController.parametersList == []
                                        ? Text('Horas de trabalho:  ${0.0}')
                                        : Text('Horas de trabalho:  ${_homeController.loadWorkedHours().toStringAsFixed(1)}'),
                                    percentGoalExpense:
                                        _homeController.expenseList.isEmpty || _homeController.expenseList == [] || _homeController.goalNotEssentialExpenses == 0.0
                                            ? 0.0
                                            : (_homeController.totalNotEssencialExpenses / _homeController.goalNotEssentialExpenses),
                                    // Parâmetros gráfico de investimento
                                    goalValueInvestment: _homeController.goalsList.isEmpty || _homeController.goalsList == []
                                        ? CircularProgressIndicator()
                                        : Text('Meta:  ${moneyFormatter.format(_homeController.loadGoalInvestiment())}'),
                                    effectiveValueInvestment: _homeController.investimentList.isEmpty || _homeController.investimentList == []
                                        ? Text('Despesas:  ${moneyFormatter.format(0)}')
                                        : Text('Investido:  ${moneyFormatter.format(_homeController.loadInvestmensCurrent())}'),
                                    percentGoalInvestment:
                                        _homeController.investimentList.isEmpty || _homeController.investimentList == [] || _homeController.goalInvestiment == 0.0
                                            ? 0.0
                                            : (_homeController.totalInvestments / _homeController.goalInvestiment),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 25.0),
                      TimeIndicatorProgress(
                        percentageCurrent:
                            _homeController.parametersList.isEmpty || _homeController.parametersList == [] ? 0 : _homeController.percentagePeriodCurrent(),
                      ),
                      //
                      TimeIndicatorDescription(
                        pastDays:
                            _homeController.parametersList.isEmpty || _homeController.parametersList == [] ? 0 : _homeController.periodIndicator(DateTime.now()),
                        periodDays: _homeController.parametersList.isEmpty || _homeController.parametersList == []
                            ? 0
                            : _homeController
                                .periodIndicator(getInitialDateQuery(dayInitialPeriod: _homeController.parametersList.first.dayInitialPeriod! - 1).last),
                        percentageDaysPassed:
                            _homeController.parametersList.isEmpty || _homeController.parametersList == [] ? 0 : _homeController.percentagePeriodCurrent() * 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.8,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.INCOME_LIST, arguments: _homeController.user),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.incomeColor, borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Receitas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.EXPENSE_LIST, arguments: _homeController.user),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.expenseColor, borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Despesas',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.INVESTMENT_LIST, arguments: _homeController.user),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.investColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Investir',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                /* GestureDetector(
                  onTap: () => Get.toNamed(Routes.PROJECTION, arguments: _homeController.user),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Projeção de despesas',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
