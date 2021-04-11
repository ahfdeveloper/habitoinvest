import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';


final ThemeData appThemeData = ThemeData(

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      )
    )
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(THEMECOLOR),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )
        
      )
    )
  ),
  
  
);