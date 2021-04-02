import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class DrawerHome extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();
  
  @override
  Widget build(Object context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [   
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue[300],
              child: ClipOval(
                /* child: Image.asset(
                  controller.user.urlimage != null ? controller.user.urlimage : 'assets/user.png',
                  width: 90, 
                  height: 90,
                  fit: BoxFit.cover
                ), */
              ),
            ),
            accountName: Text('${_controller.user.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            accountEmail: Text('${_controller.user.email}'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          

          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('Definir metas'),
            onTap: (){
              Get.offAndToNamed(Routes.GOALS);
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Simular Investimento'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categorias'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Relatórios'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: (){},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ajuda'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Sobre'),
            onTap: (){},
          ),

          Divider(color: Colors.blueGrey[200],),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {LoginController().logout();},
          ),
          
        ],
      ),
    );
  }

}