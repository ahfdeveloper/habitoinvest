import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';


class HomePage extends StatelessWidget {
  final HomeController _homeController = HomeController();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hábito Invest', style: TextStyle(color: Colors.white),),
      ),

      drawer: Drawer(
        child: ListView(
          children: [   
            UserAccountsDrawerHeader(
              accountName: Text('${_homeController.user.name}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),),
              accountEmail: Text('${_homeController.user.email}', style: TextStyle(color: Colors.white70)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  _homeController.user.urlimage != null ? _homeController.user.urlimage : 'assets/user.png'
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.access_alarms),
              title: Text('Definir metas'),
              onTap: (){
                Get.offAndToNamed(Routes.GOALS);
              },
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Simular Investimento'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Categorias'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Relatórios'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Configurações'),
              onTap: (){},
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Ajuda'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Sobre'),
              onTap: (){},
            ),
            
          ],
        ),

      ),
    );

  }
}