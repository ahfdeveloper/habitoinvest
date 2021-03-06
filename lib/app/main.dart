import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';

void main() {
  // Inicialização do Firebase
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  GetStorage.init('habito_invest_app');

  // Fixar app em Portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(
    FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Não foi possível inicializar o Firebase', textDirection: TextDirection.ltr),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // Se inicialização ocorrer com sucesso, mostra a aplicação
          return GetMaterialApp(
            title: 'Hábito Invest',
            debugShowCheckedModeBanner: false,

            // Setando a localização
            localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
            supportedLocales: [const Locale('pt', 'BR')],

            //Setando as rotas
            getPages: Pages.routes,
            // Chamando a rota inicial
            initialRoute: Routes.SPLASH,
          );
        } else {
          // Enquanto a inicialização não ocorrer a aplicação fica em processo de loading
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    ),
  );
}
