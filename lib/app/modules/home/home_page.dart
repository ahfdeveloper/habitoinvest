import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/home/components/chart_card.dart';
import 'package:habito_invest_app/app/modules/home/components/navigationbar.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/drawer.dart';

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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          shadowColor: AppColors.backgroundColor,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0.0,
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Meu saldo', style: AppTextStyles.appBarTextSaldo),
              ),
              Container(
                child: Obx(
                  () {
                    if (_homeController.accountList.isEmpty || _homeController.accountList == []) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        'R\$ ${_homeController.accountList.first.balance!.toStringAsFixed(2)}',
                        style: AppTextStyles.appBarNumberSaldo,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        drawer: DrawerHome(),
        bottomNavigationBar: NavBar(),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListView(
                      children: [
                        SizedBox(height: 15.0),
                        ChartCard(
                          title: 'Despesas não essenciais',
                          goalValue: _homeController.goalsList.isEmpty || _homeController.goalsList == []
                              ? CircularProgressIndicator()
                              : _homeController.loadGoalExpenses(),
                          effectiveValue: (_homeController.expenseList.isEmpty || _homeController.expenseList == [])
                              ? Text('Despesas: R\$0.00')
                              : _homeController.loadNotEssencialExpensesCurrent(),
                          hoursValue: _homeController.parametersList.isEmpty || _homeController.parametersList == []
                              ? Text('Horas de trabalho: ')
                              : _homeController.loadWorkedHours(),
                          colorChart: AppColors.expenseColor,
                          percentGoal: _homeController.expenseList.isEmpty || _homeController.expenseList == [] || _homeController.goalNotEssentialExpenses == 0.0
                              ? 0.0
                              : (_homeController.totalNotEssencialExpenses / _homeController.goalNotEssentialExpenses),
                        ),
                        SizedBox(height: 10.0),
                        ChartCard(
                          title: 'Investimentos',
                          goalValue: _homeController.goalsList.isEmpty || _homeController.goalsList == []
                              ? CircularProgressIndicator()
                              : _homeController.loadGoalInvestiment(),
                          effectiveValue: _homeController.investimentList.isEmpty || _homeController.investimentList == []
                              ? Text('Investido: R\$0.00')
                              : _homeController.loadInvestmensCurrent(),
                          hoursValue: Text(''),
                          colorChart: AppColors.investColor,
                          percentGoal: _homeController.investimentList.isEmpty || _homeController.investimentList == [] || _homeController.goalInvestiment == 0.0
                              ? 0.0
                              : (_homeController.totalInvestments / _homeController.goalInvestiment),
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                          child: LinearProgressIndicator(
                            value: _homeController.parametersList.isEmpty || _homeController.parametersList == [] ? 0 : _homeController.percentagePeriodCurrent(),
                            color: Colors.black,
                            backgroundColor: Colors.black12,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dias passados: ${_homeController.parametersList.isEmpty || _homeController.parametersList == [] ? 0 : _homeController.periodIndicator(DateTime.now())}',
                                        style: TextStyle(fontSize: 11.0),
                                      ),
                                      Text(
                                        'Dias do período: ${_homeController.parametersList.isEmpty || _homeController.parametersList == [] ? 0 : _homeController.periodIndicator(getInitialDateQuery(_homeController.parametersList.first.dayInitialPeriod! - 1).last)}',
                                        style: TextStyle(fontSize: 11.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        (_homeController.parametersList.isEmpty || _homeController.parametersList == []
                                                    ? 0
                                                    : _homeController.percentagePeriodCurrent() * 100)
                                                .toStringAsFixed(0) +
                                            '%',
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                  GestureDetector(
                    onTap: () {
                      print(_homeController.periodIndicator(DateTime.now()));
                      print(_homeController.periodIndicator(getInitialDateQuery(_homeController.parametersList.first.dayInitialPeriod!).last));
                      print((_homeController.periodIndicator(DateTime.now()) /
                          _homeController.periodIndicator(getInitialDateQuery(_homeController.parametersList.first.dayInitialPeriod!).last)));
                    },
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
