import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/goals/components/card_widget.dart';

class GoalsPage extends StatelessWidget {
  final double spaceCard = 7.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Definir Metas', style: AppTextStyles.appBarTextLight),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.themeColor,
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CardWidget(
                      goalName: 'Investimentos',
                      goalValue: '30%',
                      goalUniverse: 'do total das receitas'),
                  SizedBox(height: spaceCard),
                  CardWidget(
                      goalName: 'Gastos não essenciais',
                      goalValue: 'R\$1.500,00',
                      goalUniverse: 'por período'),
                  SizedBox(height: spaceCard),
                  CardWidget(
                      goalName: 'Gastos não essenciais',
                      goalValue: 'R\$1.500,00',
                      goalUniverse: 'por período'),
                  SizedBox(height: spaceCard),
                  CardWidget(
                      goalName: 'Gastos não essenciais',
                      goalValue: 'R\$1.500,00',
                      goalUniverse: 'por período'),
                ],
              )),
        ],
      ),
    );
  }
}
