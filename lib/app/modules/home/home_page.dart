import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/home/components/buttonfunctions/button_function.dart';
import 'package:habito_invest_app/app/modules/home/components/timeindicator/time_indicator_description.dart';
import 'package:habito_invest_app/app/modules/home/components/timeindicator/time_indicator_progress.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/drawer/drawer.dart';
import 'components/goalschart/chart_card_home.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  final ParametersController _parametersController = Get.put(ParametersController());
  final IncomeAddUpdateController _incomeAddUpdateController = Get.put(IncomeAddUpdateController());
  final InvestmentAddUpdateController _investmentAddUpdateController = Get.put(InvestmentAddUpdateController());

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
                Text('Olá ${_homeController.user!.name}', style: AppTextStyles.appBarTextLight),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _parametersController.dropdownDay = _homeController.parametersList.first.dayInitialPeriod;
                  _parametersController.salaryTextFormController.text = _homeController.parametersList.first.salary!.toStringAsFixed(2);
                  _parametersController.workedHoursFormController.text = _homeController.parametersList.first.workedHours.toString();
                  Get.toNamed(Routes.PARAMETERS, arguments: _homeController.user);
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          drawer: DrawerHome(),
          //bottomNavigationBar: NavBar(),
          body: _homeController.goalsList.isEmpty ||
                  _homeController.goalsList == [] ||
                  _homeController.expenseList.isEmpty ||
                  _homeController.expenseList == [] ||
                  _homeController.parametersList.isEmpty ||
                  _homeController.parametersList == [] ||
                  _homeController.accountList.isEmpty ||
                  _homeController.accountList == []
              ? Center(
                  child: CircularProgressIndicator(),
                )
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
                                                  '${moneyFormatter.format(_homeController.accountList.first.balance!)}',
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
                                                onPressed: () => Get.toNamed(Routes.PROJECTION, arguments: _homeController.user),
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
                                          goalValueExpense: Text('Meta:  ${moneyFormatter.format(_homeController.loadGoalExpenses())}'),
                                          effectiveValueExpense: Text('Despesas:  ${moneyFormatter.format(_homeController.loadNotEssencialExpensesCurrent())}'),
                                          hoursValueExpense: Text('Horas de trabalho:  ${_homeController.loadWorkedHours().toStringAsFixed(1)}'),
                                          percentGoalExpense: (_homeController.totalNotEssencialExpenses / _homeController.goalNotEssentialExpenses),
                                          // Parâmetros gráfico de investimento
                                          goalValueInvestment: Text('Meta:  ${moneyFormatter.format(_homeController.loadGoalInvestiment())}'),
                                          effectiveValueInvestment: Text('Investido:  ${moneyFormatter.format(_homeController.loadInvestmensCurrent())}'),
                                          percentGoalInvestment: (_homeController.totalInvestments / _homeController.goalInvestiment),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 25.0),
                            TimeIndicatorProgress(
                              percentageProgress: _homeController.percentagePeriodCurrent() * 100,
                              percentageCurrent: _homeController.percentagePeriodCurrent(),
                            ),
                            //
                            TimeIndicatorDescription(
                              pastDays: _homeController.periodIndicator(DateTime.now()),
                              periodDays: _homeController.periodIndicator(
                                getInitialDateQuery(dayInitialPeriod: _homeController.parametersList.first.dayInitialPeriod! - 1).last,
                              ),
                              percentageDaysPassed: _homeController.percentagePeriodCurrent() * 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 13,
                      childAspectRatio: 0.75,
                      children: [
                        ButtonFunction(
                          icon: Icons.monetization_on,
                          colorButton: AppColors.incomeColor,
                          label: 'Receitas',
                          onTap: () => Get.toNamed(Routes.INCOME_LIST, arguments: _homeController.user),
                          onPressed: () {
                            _incomeAddUpdateController.addEditFlag = 'NEW';
                            moneyValueController.updateValue(0.0);
                            Get.toNamed(Routes.INCOME_ADDUPDATE, arguments: _homeController.user);
                          },
                        ),
                        //
                        ButtonFunction(
                          icon: Icons.payment,
                          colorButton: AppColors.expenseColor,
                          label: 'Despesas',
                          onTap: () => Get.toNamed(Routes.EXPENSE_LIST, arguments: _homeController.user),
                          onPressed: () {
                            moneyValueController.updateValue(0.0);
                            Get.toNamed(Routes.EXPENSE_ADD, arguments: _homeController.user);
                          },
                        ),
                        //
                        ButtonFunction(
                          icon: Icons.moving_outlined,
                          colorButton: AppColors.investColor,
                          label: 'Investimentos',
                          onTap: () => Get.toNamed(Routes.INVESTMENT_LIST, arguments: _homeController.user),
                          onPressed: () {
                            _investmentAddUpdateController.addEditFlag = 'NEW';
                            moneyValueController.updateValue(0.0);
                            Get.toNamed(Routes.INVESTMENT_ADDUPDATE, arguments: _homeController.user);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
