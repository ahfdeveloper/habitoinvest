import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/home/components/navigationbar.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/drawer.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

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
          title: Column(
            children: [
              Text('Meu saldo', style: AppTextStyles.appBarTextSaldo),
              Text('R\$2.000,00', style: AppTextStyles.appBarNumberSaldo),
            ],
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        drawer: DrawerHome(),
        bottomNavigationBar: NavBar(),
        body: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Center(child: Text('Aqui vão os gráficos')),
            )),
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
                  onTap: () => Get.toNamed(
                    Routes.INCOME_LIST,
                    arguments: _homeController.user,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.incomeColor, borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Receitas',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }
}
