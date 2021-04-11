import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class GoalsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Definir Metas'),
        backgroundColor: THEMECOLOR,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  elevation: 3.0,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DEFINITION_GOALS, arguments: 'Investimentos');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1, child: Icon(Icons.monetization_on, color: Colors.grey[700]),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Investimentos',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16, color: GENERALLYDEFAULTCOLOR),
                                ),
                                
                                Text(
                                  '30%',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                                ),

                                Text(
                                  'do total das receitas',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: GENERALLYDEFAULTCOLOR),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),

                Card(
                  elevation: 3.0,
                  child: InkWell(
                    splashColor: Colors.deepPurple.withOpacity(0.3),
                    onTap: () {
                      Get.toNamed(Routes.DEFINITION_GOALS, arguments: 'Gastos não essenciais');
                    },
                    
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.payments, color: Colors.grey[700]),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gastos não essenciais',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16, color: GENERALLYDEFAULTCOLOR),
                                ),
                                Text(
                                  'R\$1.500,00',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  'por período',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: GENERALLYDEFAULTCOLOR),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  )
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
