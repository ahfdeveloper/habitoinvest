import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class IncomeList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas'),
      ),
      body: Center(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Nova Receita',
        child: Icon(Icons.add),
      ),
    );
  }

}