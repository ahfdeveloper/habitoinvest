import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_images/app_images.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 140.0,
                  child: Image.asset(AppImages.logo),
                ),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: controller.emailTextController,
                // Validação dos dados digitados no campo e-mail
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'E-mail',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              SizedBox(height: 6.0),
              TextFormField(
                controller: controller.passwordTextController,
                // Validação dos dados digitados no campo
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (value.length < 6) {
                    return 'Senha deve possuir no mínimo seis caracteres';
                  }
                  return null;
                },
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  labelText: 'Senha',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.themeColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      side: MaterialStateProperty.all(BorderSide(color: AppColors.themeColor))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.login();
                    }
                  },
                  child: Text(
                    'ENTRAR',
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      side: MaterialStateProperty.all(BorderSide(color: Colors.black54))),
                  onPressed: () {},
                  child: Text(
                    'Esqueci minha senha',
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Voltar',
                  style: TextStyle(color: AppColors.grey800),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
