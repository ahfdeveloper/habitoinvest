import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/core/values/app_images.dart';
import 'package:habito_invest_app/app/routes/routes.dart';

import '../../core/theme/app_colors.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Form(
          key: _formkey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 55.0,
                  child: Image.asset(AppImages.logo),
                ),
              ),
              SizedBox(height: 18.0),
              Center(child: Text('CADASTRE-SE', style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold))),
              SizedBox(height: 40.0),
              TextFormField(
                controller: controller.nameTextController,
                // Validação dos dados digitados no campo
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  } else
                    return null;
                },
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(height: 15.0),
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
                    labelText: 'E-mail',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                controller: controller.passwordTextController,
                // Validação dos dados digitados no campo senha
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
                    labelText: 'Senha',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: OutlinedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      controller.register();
                    }
                  },
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    'CADASTRAR',
                    style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: TextButton(
                  onPressed: () => Get.toNamed(Routes.WELCOME),
                  child: Text(
                    'Voltar',
                    style: TextStyle(color: Colors.black54, fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
