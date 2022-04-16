import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class EmailLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const EmailLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.themeColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(width: 16.0),
                  Icon(Icons.email_rounded, color: AppColors.white),
                  SizedBox(width: 16.0),
                  Container(
                    height: 56,
                    width: 1,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Entre com seu e-mail e senha',
                    style: AppTextStyles.buttonWhite,
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
