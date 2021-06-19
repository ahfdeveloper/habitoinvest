import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class InvestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Investimentos'),
        backgroundColor: AppColors.investcolor,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.INVEST_ADDUPDATE),
        backgroundColor: AppColors.investcolor,
        tooltip: 'Novo Investimento',
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
