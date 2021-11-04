import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class DrawerHome extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(Object context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(_homeController.user!.urlimage != null
                  ? 'assets/user.png' // '${_homeController.user!.urlimage!}'
                  : 'assets/user.png'),
            ),
            accountName: Text(
              '${_homeController.user!.name}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: AppColors.white),
            ),
            accountEmail: Text(
              '${_homeController.user!.email}',
              style: TextStyle(color: AppColors.white),
            ),
            decoration: BoxDecoration(color: AppColors.themeColor),
          ),
          ListTile(
            leading:
                Icon(Icons.track_changes, color: AppColors.bodyTextPagesColor),
            title: Text('Definir metas',
                style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.GOALS),
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: AppColors.bodyTextPagesColor),
            title: Text('Simular Investimento',
                style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.SIMULATOR),
          ),
          ListTile(
            leading: Icon(Icons.category, color: AppColors.bodyTextPagesColor),
            title:
                Text('Categorias', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.CATEGORIES_LIST,
                arguments: _homeController.user),
          ),
          ListTile(
            leading: Icon(Icons.view_list, color: AppColors.bodyTextPagesColor),
            title:
                Text('Relatórios', style: AppTextStyles.generallyTextDarkBody),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.bodyTextPagesColor),
            title:
                Text('Parâmetros', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.PARAMETERS),
          ),
          Divider(color: Colors.grey[400]),
          ListTile(
            leading: Icon(Icons.help, color: AppColors.bodyTextPagesColor),
            title: Text('Ajuda', style: AppTextStyles.generallyTextDarkBody),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info, color: AppColors.bodyTextPagesColor),
            title: Text('Sobre', style: AppTextStyles.generallyTextDarkBody),
            onTap: () {},
          ),
          Divider(color: Colors.grey[500]),
          ListTile(
            leading:
                Icon(Icons.exit_to_app, color: AppColors.bodyTextPagesColor),
            title: Text('Sair', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => LoginController().logout(),
          ),
        ],
      ),
    );
  }
}
