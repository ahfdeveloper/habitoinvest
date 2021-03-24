import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habito_invest_app/app/routes/app_pages.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:habito_invest_app/app/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init('habito_invest_app');
  
  
  runApp(
    GetMaterialApp(
      title: 'Hábito Invest',
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      
      //Setando as rotas
      getPages: AppPages.routes,
      initialRoute: Routes.INITIAL,
    )
  );
}