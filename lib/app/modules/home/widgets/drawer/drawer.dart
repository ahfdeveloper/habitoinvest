import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routes/routes.dart';
import '../../../login/login_controller.dart';
import '../../home_controller.dart';

class DrawerHome extends GetView<HomeController> {
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
              '${controller.user!.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: AppColors.white),
            ),
            accountEmail: Text(
              '${controller.user!.email}',
              style: TextStyle(color: AppColors.white),
            ),
            decoration: BoxDecoration(color: AppColors.themeColor),
          ),
          ListTile(
              leading: Icon(Icons.track_changes, color: AppColors.bodyTextPagesColor),
              title: Text('Definir metas', style: AppTextStyles.generallyTextDarkBody),
              onTap: () {
                if (controller.goalsList.first.percentageInvestiment == 0 &&
                    controller.goalsList.first.valueInvestment == 0 &&
                    controller.goalsList.first.percentageNotEssentialExpenses == 0 &&
                    controller.goalsList.first.valueNotEssentialExpenses == 0) {
                  Get.offAndToNamed(Routes.GOALS_WARNING, arguments: {'user': controller.user});
                } else {
                  Get.offAndToNamed(Routes.GOALS, arguments: {'user': controller.user});
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
            onTap: () => Get.offAndToNamed(Routes.CATEGORIES_LIST, arguments: {'user': controller.user}),
          ),
          ListTile(
            leading: Icon(Icons.view_list, color: AppColors.bodyTextPagesColor),
            title: Text('Relatórios', style: AppTextStyles.generallyTextDarkBody),
            onTap: () => Get.offAndToNamed(Routes.REPORT, arguments: {'user': controller.user}),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.bodyTextPagesColor),
            title: Text('Parâmetros', style: AppTextStyles.generallyTextDarkBody),
            onTap: () {
              Get.offAndToNamed(Routes.PARAMETERS, arguments: {
                'user': controller.user,
                'dropdownDay': controller.parametersList.first.dayInitialPeriod,
                'salaryTextFormController': controller.parametersList.first.salary!.toStringAsFixed(2),
                'workedHoursFormController': TextEditingController(text: controller.parametersList.first.workedHours.toString()),
              });
            },
          ),
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
