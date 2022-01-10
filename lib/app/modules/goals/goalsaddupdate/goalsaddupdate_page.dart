import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/decoration/decoration.dart';
import 'package:intl/intl.dart';
import 'goalsaddupdate_controller.dart';

class GoalsAddUpdatePage extends StatelessWidget {
  final GoalsAddUpdateController _goalsAddUpdateController = Get.find<GoalsAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    const dialogPadding = 5.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(_goalsAddUpdateController.title, style: TextStyle(color: AppColors.white)),
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
                            side: BorderSide(color: _goalsAddUpdateController.buttonColorPercentage),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            backgroundColor: _goalsAddUpdateController.buttonBackgroundColorPercentage,
                          ),
                          child: Text(
                            'Porcentagem',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _goalsAddUpdateController.buttonColorPercentage,
                            ),
                          ),
                          onPressed: () {
                            _goalsAddUpdateController.percentageButtonSelect();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _goalsAddUpdateController.buttonColorFixedValue),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            backgroundColor: _goalsAddUpdateController.buttonBackgroundColorFixedValue,
                          ),
                          child: Text(
                            'Valor Fixo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _goalsAddUpdateController.buttonColorFixedValue,
                            ),
                          ),
                          onPressed: () {
                            _goalsAddUpdateController.fixedValueButtonSelect();
                          },
                        ),
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
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _goalsAddUpdateController.controller,
                            showCursor: false,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: textFieldValueGoal(),
                            style: AppTextStyles.valueGoals,
                          ),
                        ),
                        // Text(
                        //   _goalsAddUpdateController.value,
                        //   style: TextStyle(fontSize: 80, color: Colors.black),
                        // ),
                        // Expanded(
                        //   child: Text(
                        //     _goalsAddUpdateController.endValue,
                        //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('*Última atualização: ' + DateFormat('dd/MM/yyyy').format(_goalsAddUpdateController.dateUpdate)),
      ),
    );
  }
}
