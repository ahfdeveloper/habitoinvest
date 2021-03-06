import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/values/app_images.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(BorderSide(color: AppColors.stroke)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(width: 16.0),
                    Image.asset(AppImages.google),
                    SizedBox(width: 16.0),
                    Container(height: 56, width: 1, color: AppColors.stroke),
                  ],
                )),
            Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Entrar com Google', style: AppTextStyles.buttonGray),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
