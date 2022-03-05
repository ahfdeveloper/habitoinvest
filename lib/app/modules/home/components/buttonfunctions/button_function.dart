import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';

class ButtonFunction extends StatelessWidget {
  final Color colorButton;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;

  const ButtonFunction({
    Key? key,
    required this.icon,
    required this.colorButton,
    required this.label,
    this.onTap,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorButton,
          border: Border.all(color: AppColors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.0, top: 8.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.white,
                    size: 30.0,
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 6.0),
                      child: Text(
                        label,
                        style: GoogleFonts.notoSans(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: colorButton),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: colorButton,
                      ),
                      iconSize: 35.0,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
