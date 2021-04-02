import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_controller.dart';
import 'package:habito_invest_app/app/theme/app_theme.dart';

class GoalsDefinitionPage extends StatelessWidget{
  final GoalsDefinitionController controller = GoalsDefinitionController();

  @override
  Widget build(BuildContext context) {
    const dialogPadding = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: Container(
        child: Obx(
          () =>  Column(
            children:[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: controller.buttonColorPercentage),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Text(
                        'Porcentagem',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.buttonColorPercentage,
                        )
                      ),

                      onPressed: () {  
                        controller.percentageButtonSelect();
                      }
                    ),
                  ),

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: controller.buttonColorFixedValue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: Text(
                        'Valor Fixo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: controller.buttonColorFixedValue,
                        )
                      ),

                      onPressed: () {  
                      controller.fixedValueButtonSelect();
                      }
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(dialogPadding),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.inicioValor,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Text(
                            controller.valor,
                            style: TextStyle(
                              fontSize: 80,
                              color: Colors.black
                            ),
                          ),
  
                        Text(
                          controller.fimValor,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              
              Padding(
                padding: EdgeInsets.all(dialogPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: appThemeData.elevatedButtonTheme.style,
                          child: Text("Cancelar"),
                        ),
                      ),
                    ),

                    Expanded( 
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: appThemeData.elevatedButtonTheme.style,
                          child: Text("Salvar"),
                        ),
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );

  }
}
    