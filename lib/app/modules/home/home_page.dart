import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_masks.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/buttonfunctions/button_function.dart';
import 'widgets/drawer/drawer.dart';
import 'widgets/goalschart/chart_card_home.dart';
import 'widgets/timeindicator/timeindicator_card.dart';

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
          body: _homeController.goalsList.isEmpty ||
                  _homeController.goalsList == [] ||
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
                                          goalValueExpense: _homeController.loadGoalExpenses(),
                                          effectiveValueExpense: _homeController.loadNotEssencialExpensesCurrent(),
                                          hoursValueExpense: _homeController.loadWorkedHours(),
                                          percentGoalExpense: _homeController.goalNotEssentialExpenses == 0
                                              ? 0
                                              : (_homeController.totalNotEssencialExpenses / _homeController.goalNotEssentialExpenses),
                                          // Parâmetros gráfico de investimento
                                          goalValueInvestment: _homeController.loadGoalInvestiment(),
                                          effectiveValueInvestment: _homeController.loadInvestmensCurrent(),
                                          percentGoalInvestment:
                                              _homeController.goalInvestiment == 0 ? 0 : (_homeController.totalInvestments / _homeController.goalInvestiment),
                                        ),
                                        TimeIndicatorCard(
                                          percentageCurrent: _homeController.percentagePeriodCurrent(),
                                          percentageDaysPassed: _homeController.percentagePeriodCurrent() * 100,
                                          percentageProgress: _homeController.percentagePeriodCurrent() * 100,
                                          pastDays: _homeController.periodIndicator(DateTime.now()),
                                          periodDays: _homeController.periodIndicator(
                                            getInitialDateQuery(dayInitialPeriod: _homeController.parametersList.first.dayInitialPeriod! - 1).last,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //
                            /* SizedBox(height: 10.0),
                            Container(
                              color: Colors.amber,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        //height: 75.0,
                                        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Maiores despesas não xxx xxx xxx xxx essenciais nos últimos 6 meses',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.notoSans(fontSize: 11.0, color: AppColors.bodyTextPagesColor),
                                              ),
                                              Text('Lazer',
                                                  style: GoogleFonts.notoSans(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.bodyTextPagesColor)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Container(
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
                                              Text('R\S0,00',
                                                  style: GoogleFonts.notoSans(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.bodyTextPagesColor)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ), */
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
                                        Text('R\S0,00',
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
                                    //Get.toNamed(Routes.INVESTMENT_ADDUPDATE, arguments: _homeController.user);
                                    Navigator.pushNamed(context, Routes.INVESTMENT_ADDUPDATE, arguments: _homeController.user);
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
