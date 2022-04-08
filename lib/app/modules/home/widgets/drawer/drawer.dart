import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import '../../../../widgets/app_colors.dart';
import '../../../../widgets/app_text_styles.dart';

class DrawerHome extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final ParametersController _parametersController = Get.find<ParametersController>();

  @override
  Widget build(Object context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: Size.square(40),
            currentAccountPicture: Image.asset('assets/user1.png'),
            accountName: Text(
              '${_homeController.user!.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: AppColors.white),
            ),
            accountEmail: Text(
              '${_homeController.user!.email}',
              style: TextStyle(color: AppColors.white),
            ),
            decoration: BoxDecoration(color: AppColors.themeColor),
          ),
          ListTile(
              leading: Icon(Icons.track_changes, color: AppColors.bodyTextPagesColor),
              title: Text('Definir metas', style: AppTextStyles.generallyTextDarkBody),
              onTap: () {
                if (_homeController.goalsList.first.percentageInvestiment == 0 &&
                    _homeController.goalsList.first.valueInvestment == 0 &&
                    _homeController.goalsList.first.percentageNotEssentialExpenses == 0 &&
                    _homeController.goalsList.first.valueNotEssentialExpenses == 0) {
                  Get.offAndToNamed(Routes.GOALS_WARNING, arguments: _homeController.user);
                } else {
                  Get.offAndToNamed(Routes.GOALS, arguments: _homeController.user);
                }
              }),
          ListTile(
            leading: Icon(Icons.calculate, color: AppColors.bodyTextPagesColor),
            title: Text('Simular Investimento', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.SIMULATOR),
          ),
          ListTile(
            leading: Icon(Icons.category, color: AppColors.bodyTextPagesColor),
            title: Text('Categorias', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.CATEGORIES_LIST, arguments: _homeController.user),
          ),
          ListTile(
            leading: Icon(Icons.view_list, color: AppColors.bodyTextPagesColor),
            title: Text('Relatórios', style: AppTextStyles.generallyTextDarkBody),
            onTap: () {},
          ),
          ListTile(
              leading: Icon(Icons.settings, color: AppColors.bodyTextPagesColor),
              title: Text('Parâmetros', style: AppTextStyles.generallyTextDarkBody),
              onTap: () {
                _parametersController.dropdownDay = _homeController.parametersList.first.dayInitialPeriod;
                _parametersController.salaryTextFormController.text = _homeController.parametersList.first.salary!.toStringAsFixed(2);
                _parametersController.workedHoursFormController.text = _homeController.parametersList.first.workedHours.toString();
                Get.offAndToNamed(Routes.PARAMETERS, arguments: _homeController.user);
              }),
          Divider(color: Colors.grey[400]),
          ListTile(
            leading: Icon(Icons.info, color: AppColors.bodyTextPagesColor),
            title: Text('Sobre', style: AppTextStyles.generallyTextDarkBody),
            onTap: () {},
          ),
          Divider(color: Colors.grey[500]),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: AppColors.bodyTextPagesColor),
            title: Text('Sair', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => LoginController().logout(),
          ),
        ],
      ),
    );
  }
}
