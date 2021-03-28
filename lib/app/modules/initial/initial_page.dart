import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/initial/initial_controller.dart';

// Implementação do SplashScreen do app
class InitialPage extends GetView<InitialController> {
  
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.all(80.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/moeda.png'),
            fit: BoxFit.contain
          )
        ),
      )
    );  
  }
}