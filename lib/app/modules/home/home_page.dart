import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
            children: [
              Obx(() => Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        ChartCard(
                          title: 'Gastos não essenciais',
                          effective: 'Gastos: ',
                          goalValue: _homeController.goalsList.isEmpty || _homeController.goalsList == [] ? CircularProgressIndicator() : loadGoalExpenses(),
                          effectiveValue: _homeController.notEssExpCurrent.isEmpty || _homeController.notEssExpCurrent == []
                              ? CircularProgressIndicator()
                              : _homeController.loadNotEssencialExpenses(),
                          colorChart: AppColors.expenseColor,
                        ),
                        SizedBox(height: 10.0),
                        ChartCard(
                          title: 'Investimentos',
                          effective: 'Investido: ',
                          goalValue: _homeController.goalsList.isEmpty || _homeController.goalsList == [] ? CircularProgressIndicator() : loadGoalInvestiment(),
                          effectiveValue: CircularProgressIndicator(),
                          colorChart: AppColors.investcolor,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
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
                    onTap: () {
                      Get.toNamed(Routes.INVESTMENT_LIST, arguments: _homeController.user);
                      _homeController.onInit();
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.investcolor,
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
                    onTap: () {},
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
                            'Simular Despesa',
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

  // Retorna a meta de Gastos não essenciais
  loadGoalExpenses() {
    if (_homeController.goalsList.first.valueNotEssentialExpenses != 0.0) {
      return Text('Meta: R\$${_homeController.goalsList.first.valueNotEssentialExpenses!.toStringAsFixed(2)}');
    } else {
      return Text('Meta: ${_homeController.goalsList.first.percentageNotEssentialExpenses.toString()}% das receitas');
    }
  }

  // Retorna a meta de Investimentos
  loadGoalInvestiment() {
    if (_homeController.goalsList.first.valueInvestment != 0.0) {
      return Text('Meta: R\$${_homeController.goalsList.first.valueInvestment!.toStringAsFixed(2)}');
    } else {
      return Text('Meta: ${_homeController.goalsList.first.percentageInvestiment.toString()}% das receitas');
    }
  }
}
