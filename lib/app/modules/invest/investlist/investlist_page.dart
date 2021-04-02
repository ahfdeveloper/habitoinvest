import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class InvestList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investimentos', style: TextStyle(color: TEXTCOLORDARK)),
        backgroundColor: INVESTCOLOR,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.INCOME_ADD),
        backgroundColor: INVESTCOLOR,
        tooltip: 'Novo Investimento',
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

}