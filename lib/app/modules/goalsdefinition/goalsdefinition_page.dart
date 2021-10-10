import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_controller.dart';

class GoalsDefinitionPage extends StatelessWidget {
  final GoalsDefinitionController _controller = GoalsDefinitionController();

  @override
  Widget build(BuildContext context) {
    const dialogPadding = 5.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title:
            Text(_controller.title, style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.themeColor,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () {/*Código para salvar*/},
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Container(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: _controller.buttonColorPercentage),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              backgroundColor:
                                  _controller.buttonBackgroundColorPercentage,
                            ),
                            child: Text('Porcentagem',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _controller.buttonColorPercentage,
                                )),
                            onPressed: () {
                              _controller.percentageButtonSelect();
                            }),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: _controller.buttonColorFixedValue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              backgroundColor:
                                  _controller.buttonBackgroundColorFixedValue,
                            ),
                            child: Text('Valor Fixo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _controller.buttonColorFixedValue,
                                )),
                            onPressed: () {
                              _controller.fixedValueButtonSelect();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(dialogPadding),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _controller.inicioValor,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _controller.valor,
                          style: TextStyle(fontSize: 80, color: Colors.black),
                        ),
                        Text(
                          _controller.fimValor,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
