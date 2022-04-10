import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_decoration.dart';
import '../../../core/theme/app_text_styles.dart';
import 'goalsupdate_controller.dart';

class GoalsUpdatePage extends StatelessWidget {
  final GoalsUpdateController _goalsUpdateController = Get.find<GoalsUpdateController>();

  @override
  Widget build(BuildContext context) {
    const dialogPadding = 5.0;
    final _formkey = _goalsUpdateController.formkey;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(_goalsUpdateController.title, style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.themeColor,
        actions: [
          IconButton(
            onPressed: () => _goalsUpdateController.cancel(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () => _goalsUpdateController.updateGoal(),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Form(
        key: _formkey,
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
                            side: BorderSide(color: _goalsUpdateController.buttonColorPercentage),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            backgroundColor: _goalsUpdateController.buttonBackgroundColorPercentage,
                          ),
                          child: Text(
                            'Porcentagem',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _goalsUpdateController.buttonColorPercentage,
                            ),
                          ),
                          onPressed: () {
                            _goalsUpdateController.percentageButtonSelect();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _goalsUpdateController.buttonColorFixedValue),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            backgroundColor: _goalsUpdateController.buttonBackgroundColorFixedValue,
                          ),
                          child: Text(
                            'Valor Fixo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _goalsUpdateController.buttonColorFixedValue,
                            ),
                          ),
                          onPressed: () {
                            _goalsUpdateController.fixedValueButtonSelect();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _goalsUpdateController.pVisible,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(dialogPadding),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(flex: 2, child: Container()),
                          Expanded(
                            child: TextFormField(
                              validator: (value) => validator(value),
                              controller: _goalsUpdateController.controller,
                              autofocus: true,
                              showCursor: false,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.grey300))),
                              style: AppTextStyles.valueGoals,
                              inputFormatters: [LengthLimitingTextInputFormatter(_goalsUpdateController.maxLength)],
                            ),
                          ),
                          Expanded(flex: 2, child: Text(' %', style: AppTextStyles.valueGoals)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _goalsUpdateController.fVisible,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(dialogPadding),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              validator: (value) => validatorValue(value),
                              controller: _goalsUpdateController.controller,
                              autofocus: true,
                              showCursor: false,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: textFieldValueGoal(),
                              style: AppTextStyles.valueGoals,
                              inputFormatters: [LengthLimitingTextInputFormatter(_goalsUpdateController.maxLength)],
                            ),
                          ),
                        ],
                      ),
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
