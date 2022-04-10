import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/core/utils/app_functions.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_text_styles.dart';

class ParametersPage extends StatelessWidget {
  final ParametersController _parameterController = Get.find<ParametersController>();

  @override
  Widget build(BuildContext context) {
    final _formkey = _parameterController.formkey;
    final Color interfaceColor = AppColors.themeColor;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => cancel()),
        backgroundColor: interfaceColor,
        title: Text('Parâmetros do usuário', style: AppTextStyles.appBarTextLight),
        actions: [
          IconButton(
            onPressed: () => _parameterController.updateParameter(),
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Obx(
        () => Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Text('Dia de início do período de apuração: *', style: AppTextStyles.generallyTextDarkBody),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, color: AppColors.bodyTextPagesColor),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: _parameterController.dropdownDay,
                        icon: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.chevron_right),
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: AppColors.bodyTextPagesColor,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w700,
                        ),
                        underline: Container(
                          height: 1.0,
                          color: AppColors.grey800,
                        ),
                        onChanged: (int? newValue) => _parameterController.dropdownDay = newValue,
                        items: _parameterController.daysMonth.map<DropdownMenuItem<int>>((value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Center(child: Text('$value')),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                Text(
                  '*Informe o dia do mês que deseja que se inicie o período de apuração de suas metas.',
                  style: AppTextStyles.generallyLittleTextDarkBody,
                ),
                SizedBox(height: 35.0),
                Text('Renda Mensal: *', style: AppTextStyles.generallyTextDarkBody),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _parameterController.salaryTextFormController,
                        validator: (value) => validator(value),
                        decoration: textFormFieldFormsWithUnderline(fieldIcon: Icons.monetization_on_rounded, hint: null),
                        style: TextStyle(
                          color: AppColors.bodyTextPagesColor,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w700,
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text('*Informe o valor médio de sua renda mensal', style: AppTextStyles.generallyLittleTextDarkBody),
                SizedBox(height: 35.0),
                Text('Horas trabalhadas: *', style: AppTextStyles.generallyTextDarkBody),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        controller: _parameterController.workedHoursFormController,
                        validator: (value) => validator(value),
                        decoration: textFormFieldFormsWithUnderline(fieldIcon: Icons.watch_later, hint: null),
                        style: TextStyle(
                          color: AppColors.bodyTextPagesColor,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w700,
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text('*Informe a quantidade média de horas trabalhadas por semana.', style: AppTextStyles.generallyLittleTextDarkBody),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
