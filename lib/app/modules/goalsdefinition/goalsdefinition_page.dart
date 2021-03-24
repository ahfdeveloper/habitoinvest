import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_controller.dart';

class GoalsDefinitionPage extends StatelessWidget{
final GoalsDefinitionController _goalsDefinitionController = GoalsDefinitionController();

  @override
  Widget build(BuildContext context) {
    
    const dialogPadding = 8.0;

    return Scaffold(
      appBar: AppBar(title: Text('XXX')),
      body: Container(
        height: 500.0,
        child: Obx(
          () =>  Column(
            children:[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        backgroundColor: _goalsDefinitionController.buttonBackgroundPercentage.value,
                      ),
                      child: Text(
                        'Porcentagem',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _goalsDefinitionController.buttonTextPercentage.value,
                        )
                      ),

                      onPressed: () {  
                        _goalsDefinitionController.percentageButtonSelect();
                      }
                    ),
                  ),

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        backgroundColor: _goalsDefinitionController.buttonBackgroundFixedValue.value,
                      ),
                      child: Text(
                        'Valor Fixo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _goalsDefinitionController.buttonTextFixedValue.value,
                        )
                      ),

                      onPressed: () {  
                        //https://coflutter.com/flutter-how-to-show-dismiss-keyboard/  ---------para quando clicar abrir o teclado
                      _goalsDefinitionController.fixedValueButtonSelect();
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
                            _goalsDefinitionController.inicioValor.value,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),
                          ),
    
                          TextButton(
                            autofocus: true, 
                            child: Text(
                              _goalsDefinitionController.valor.value,
                              style: TextStyle(
                                fontSize: 80,
                                color: Colors.black
                              ),
                            ),
                            onPressed: () { },
                          ),
    
                          Text(
                            _goalsDefinitionController.fimValor.value,
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
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(dialogPadding),
                            backgroundColor: Get.theme.primaryColor,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded( 
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(dialogPadding),
                            backgroundColor: Get.theme.primaryColor
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Salvar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
    