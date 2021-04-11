import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/modules/home/components/navigationbar.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/drawer.dart';


class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ), 
    
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: BACKGROUNDCOLOR,
          title: Column(
            children: [
              Text('Meu saldo', style: TextStyle(fontSize: 11.0, color: TEXTCOLORDARK)),
              Text('R\$2.000,00', style: TextStyle(color: TEXTCOLORDARK, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        backgroundColor: BACKGROUNDCOLOR,
        drawer: DrawerHome(),
        bottomNavigationBar: NavigationBar(),

        body: Column(
          children: [

            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Center(child: Text('Aqui vão os gráficos')),
              )
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
                  onTap: () => Get.toNamed(Routes.INCOME_LIST),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: INCOMECOLOR,
                      borderRadius: BorderRadius.circular(15)
                    ),
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
                  onTap: () => Get.toNamed(Routes.EXPENSE_LIST),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: EXPENSECOLOR,
                      borderRadius: BorderRadius.circular(15)
                    ),
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
                  onTap: () => Get.toNamed(Routes.INVEST_LIST),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: INVESTCOLOR,
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
                  onTap: (){},
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
                          style: TextStyle(fontWeight: FontWeight.bold)
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