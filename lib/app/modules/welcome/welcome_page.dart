import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/values/app_images.dart';
import 'widgets/email_login_button.dart';
import 'widgets/social_login_button.dart';

class WelcomePage extends GetView<LoginController> {
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              height: 280,
              width: 280,
              child: Image.asset(AppImages.logo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 37.0, right: 37.0),
            child: Text(
              'Controle seus gastos de forma prática e torne-se um investidor',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleHome,
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: EmailLoginButton(
                    onTap: () => Get.toNamed(Routes.LOGIN),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 40.0, right: 40.0),
                  child: SocialLoginButton(
                    onTap: () {
                      _loginController.googleSignIn();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Novo por aqui?',
                      style: AppTextStyles.textBlack,
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.REGISTER_USER),
                      child: Text('Cadastre-se'),
                    ),
                    SizedBox(height: 80.0)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
