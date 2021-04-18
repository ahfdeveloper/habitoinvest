import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';


InputDecoration textFormFieldDecoration1(String label, String hint, bool multilines){
  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    alignLabelWithHint: multilines,
  );
}


// Decoration para TextFormFields alternativo
InputDecoration textFormFieldDecoration2(String label, Color borderFocus, bool multilines){
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    hintText: 'p.ex. 0.00',
    labelStyle: TextStyle(fontWeight: FontWeight.bold, color: GENERALLYDEFAULTCOLOR, fontSize: 18),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0), 
      borderSide: BorderSide(color: Colors.grey[100]),
    ),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderFocus)),
    alignLabelWithHint: multilines,
  );
}