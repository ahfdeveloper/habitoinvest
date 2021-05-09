import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class CategoriesList extends StatelessWidget{
  final Color interfaceColor = AppColors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Categorias', style: AppTextStyles.appBarTextLight),
        backgroundColor: interfaceColor,
      ),
      body: Center(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CATEGORIES_ADDUPDATE),
        backgroundColor: interfaceColor,
        tooltip: 'Nova Categoria',
        child: Icon(Icons.add),
      ),
    );
  }

}