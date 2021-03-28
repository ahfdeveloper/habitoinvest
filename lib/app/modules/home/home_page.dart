import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/home/components/navigationbar.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'components/drawer.dart';


class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.transparent,
        title: Column(
          children: [
            Text('Meu saldo', style: TextStyle(color: Colors.black, fontSize: 10.0),),
            Text('R\$2.000,00', style: TextStyle(color: Colors.black),)
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
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
                  onTap: (){Get.toNamed(Routes.INCOME_LIST);},
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Receita')
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Despesa')
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Investir')
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
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Simular Despesa')
                      ],
                    ),
                  ),
                ),
              ],    
            ),
          ],
        ),
      );
      

    

  }
}