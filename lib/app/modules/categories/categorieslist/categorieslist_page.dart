import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class CategoriesList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        backgroundColor: THEMECOLOR,
      ),
      body: Center(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CATEGORIES_ADDUPDATE),
        backgroundColor: THEMECOLOR,
        tooltip: 'Nova Categoria',
        child: Icon(Icons.add),
      ),
    );
  }

}