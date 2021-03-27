import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  accentColor: Colors.cyan[200],
  appBarTheme: AppBarTheme(color: Colors.blue),


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
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )
        
      )
    )
  ),
  
  
);