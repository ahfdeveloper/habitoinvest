import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:habito_invest_app/app/modules/login/login_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:get/get.dart';


class LoginPage extends GetView<LoginController> {
  //final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
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
                  radius: 40.0,
                  child: Image.asset('assets/moeda.png'),
                ),
              ),

              SizedBox(height: 48.0),

              TextFormField(
                controller: controller.emailTextController,
                // Validação dos dados digitados no campo e-mail
                validator: (value) {
                  if(value.isEmpty){
                    return 'Campo obrigatório';
                  } else if(!GetUtils.isEmail(value)){
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),

              SizedBox(height: 15.0),

              TextFormField(
                controller: controller.passwordTextController,
                // Validação dos dados digitados no campo
                validator: (value){
                  if(value.isEmpty){
                    return 'Campo obrigatório';
                  } else if(value.length < 6){
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
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Get.theme.primaryColor),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      controller.login();
                    }
                  }, 
                  child: Text(
                    'ENTRAR', 
                    style: TextStyle(
                      fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold
                    )
                  )
                )  
              ),

              Padding(
                padding: EdgeInsets.zero,
                child: OutlinedButton(
                  onPressed: (){
                    Get.offAndToNamed(Routes.REGISTER);
                  }, 
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text('CADASTRE-SE', style: TextStyle(fontSize: 14.0))
                )
              ),

              TextButton(
                onPressed: (){},
                child: Text(
                  'Esqueci minha senha', 
                  style: TextStyle(color: Colors.black54, fontSize: 15.0)
                )
              )
            ],
          ),
        ),
      ),
    
    );
  }
}