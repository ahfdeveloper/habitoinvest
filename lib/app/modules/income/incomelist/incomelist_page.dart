import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class IncomeList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas'),
        backgroundColor: INCOMECOLOR,
      ),
      body: Center(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.INCOME_ADD),
        backgroundColor: INCOMECOLOR,
        tooltip: 'Nova Receita',
        child: Icon(Icons.add),
      ),
    );
  }

}