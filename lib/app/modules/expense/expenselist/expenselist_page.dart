import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class ExpenseList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
      appBar: AppBar(
        title: Text('Despesas'),
        backgroundColor: EXPENSECOLOR,
      ),
      body: Center(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.EXPENSE_ADDUPDATE),
        backgroundColor: EXPENSECOLOR,
        tooltip: 'Nova Despesa',
        child: Icon(Icons.add),
      ),
    );
  }

}