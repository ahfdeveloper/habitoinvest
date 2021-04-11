import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habito_invest_app/app/routes/app_pages.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:habito_invest_app/app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init('habito_invest_app');

  // Fixar app em Portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  
  runApp(
    GetMaterialApp(
      title: 'Hábito Invest',
      debugShowCheckedModeBanner: false,
      theme: appThemeData,

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      
      //Setando as rotas
      getPages: AppPages.routes,
      initialRoute: Routes.SPLASH,
    )
  );
}