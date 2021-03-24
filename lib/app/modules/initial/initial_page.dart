import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:splashscreen/splashscreen.dart';


// Implementação do SplashScreen do app
class InitialPage extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        SplashScreen(
          seconds: 5,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft, 
            colors: [Colors.blue, Colors.blueAccent],
          ),
          navigateAfterSeconds: Routes.LOGIN,
          loaderColor: Colors.transparent,
        ),

        Container(
          margin: EdgeInsets.all(80.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/moeda.png'),
              fit: BoxFit.contain
            )
          ),
        )
      ],
    ); 
  }
}