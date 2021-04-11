import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
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
              backgroundColor: THEMECOLOR,
              child: ClipOval(
                child: Image.asset(
                  _controller.user.urlimage != null ? _controller.user.urlimage : 'assets/user.png',
                  width: 90, 
                  height: 90,
                  fit: BoxFit.cover
                ),
              ),
            ),
            accountName: Text('${_controller.user.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: TEXTCOLORLIGHT)),
            accountEmail: Text('${_controller.user.email}', style: TextStyle(color: TEXTCOLORLIGHT),),
            decoration: BoxDecoration(
              color: THEMECOLOR,
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.track_changes, color: GENERALLYDEFAULTCOLOR),
            title: Text('Definir metas', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: (){
              Get.offAndToNamed(Routes.GOALS);
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: GENERALLYDEFAULTCOLOR),
            title: Text('Simular Investimento', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.category, color: GENERALLYDEFAULTCOLOR,),
            title: Text('Categorias', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.view_list, color: GENERALLYDEFAULTCOLOR),
            title: Text('Relatórios', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: (){},
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.help, color: GENERALLYDEFAULTCOLOR),
            title: Text('Ajuda', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.info, color: GENERALLYDEFAULTCOLOR),
            title: Text('Sobre', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: (){},
          ),

          Divider(color: Colors.grey[500],),

          ListTile(
            leading: Icon(Icons.exit_to_app, color: GENERALLYDEFAULTCOLOR),
            title: Text('Sair', style: TextStyle(color: GENERALLYDEFAULTCOLOR)),
            onTap: () {LoginController().logout();},
          ),
          
        ],
      ),
    );
  }

}