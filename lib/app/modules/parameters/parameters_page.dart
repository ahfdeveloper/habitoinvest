import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_controller.dart';

class ParametersPage extends StatelessWidget {
  final ParametersController _controller = ParametersController();

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    List<int> daysMonth = [];

    for (int i = 1; i <= 31; i++) {
      daysMonth.add(i);
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: interfaceColor,
        title: Text('Parâmetros do usuário'),
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
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text('Dia de início do período de apuração: *',
                style: AppTextStyles.generallyTextDarkBody),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Obx(() => DropdownButton<String>(
                        isExpanded: true,
                        value: _controller.dropdownDayType,
                        icon: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.chevron_right),
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: AppColors.bodyTextPagesColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                        underline: Container(
                          height: 2,
                          color: AppColors.grey800,
                        ),
                        onChanged: (String? newValue) =>
                            _controller.dropdownDayType = newValue,
                        items: <String>['Dia fixo', 'Dia útil']
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                ),
                SizedBox(width: 25.0),
                Expanded(
                  flex: 1,
                  child: Obx(() => DropdownButton<int>(
                        isExpanded: true,
                        value: _controller.dropdownDay,
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
                          height: 2.0,
                          color: AppColors.grey800,
                        ),
                        onChanged: (int? newValue) =>
                            _controller.dropdownDay = newValue,
                        items: daysMonth.map<DropdownMenuItem<int>>((value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text('$value'),
                          );
                        }).toList(),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              '*Informe o dia do mês que deseja que se inicie o período de apuração de suas ' +
                  'metas. Você pode informar esse período como sendo um dia fixo (por exemplo ' +
                  'todo dia 05), ou um dia útil (por exemplo todo 7º dia útil).',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
