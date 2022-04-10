import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String? label;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final VoidCallback? onTap;

  ButtonWidget.black({String? label, VoidCallback? onTap})
      : this.backgroundColor = AppColors.themeColor,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.themeColor,
        this.onTap = onTap,
        this.label = label;

  ButtonWidget.transparent({String? label, VoidCallback? onTap})
      : this.backgroundColor = AppColors.transparent,
        this.fontColor = AppColors.themeColor,
        this.borderColor = AppColors.themeColor,
        this.onTap = onTap,
        this.label = label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            side: MaterialStateProperty.all(BorderSide(color: borderColor))),
        onPressed: onTap,
        child: Text(
          label!,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
