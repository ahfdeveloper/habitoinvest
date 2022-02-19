import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';

// Estilo dos TextFormFields usados no app. Padrão material design
InputDecoration textFormFieldForms({
  IconData? fieldIcon,
  String? label,
  required String? hint,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(fieldIcon, color: AppColors.grey600),
      ],
    ),
    hintText: hint,
  );
}

InputDecoration textFormFieldFormsWithUnderline({
  IconData? fieldIcon,
  String? label,
  required String? hint,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.zero,
    border: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey300)),
    icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(fieldIcon, color: AppColors.grey600),
      ],
    ),
    hintText: hint,
  );
}

InputDecoration textFormFieldFormsLabel({
  IconData? fieldIcon,
  required String? label,
  required String? hint,
}) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(fieldIcon, color: AppColors.grey600),
      ],
    ),
  );
}

InputDecoration textFormFieldMultilines(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: AppColors.grey300),
    ),
    alignLabelWithHint: true,
  );
}

// Estilo do TextFormField para inserção do valor das operações
InputDecoration textFormFieldValueOperation() {
  return InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
    ),
  );
}

// Estilo do TextField para inserção dos valores das metas
InputDecoration textFieldValueGoal() {
  return InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 80.0,
    ),
  );
}

// Estilo dos TextFormFields usados no app. Padrão com bordas
InputDecoration textFormFieldDecoration2(String label, Color borderFocus, bool multilines) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    hintText: 'p.ex. 0.00',
    labelStyle: TextStyle(fontWeight: FontWeight.bold, color: AppColors.bodyTextPagesColor, fontSize: 18),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Colors.grey[100]!),
    ),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderFocus)),
    alignLabelWithHint: multilines,
  );
}
