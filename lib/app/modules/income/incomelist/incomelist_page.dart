import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class IncomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas'),
        backgroundColor: AppColors.incomeColor,
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => Get.toNamed(Routes.INCOME_ADDUPDATE),
        backgroundColor: AppColors.incomeColor,
        tooltip: 'Nova Receita',
        child: Icon(Icons.add),
      ),
    );
  }
}
