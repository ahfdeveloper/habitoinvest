import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/core/theme/app_colors.dart';

import '../../../core/theme/app_text_styles.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({required controller})
      : super(
          preferredSize: Size.fromHeight(115.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: AppColors.expenseColor,
                automaticallyImplyLeading: true,
                leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
                title: controller.searchBoolean == false
                    ? Text('Despesas')
                    : TextFormField(
                        controller: controller.searchFormFieldController,
                        style: AppTextStyles.appBarTextLight,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Descrição da receita',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        onChanged: (value) => controller.runFilter(value),
                      ),
                actions: [
                  // Determina qual botão vai aparece no appBar de acordo com a ação do usuário
                  controller.searchBoolean == false
                      ? IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => controller.searchBoolean = true,
                        )
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            controller.searchBoolean = false;
                            controller.expenseList = controller.result;
                            controller.searchFormFieldController.clear();
                          },
                        ),
                ],
              ),
              Container(
                color: AppColors.expenseColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(controller.buttonBackgroundColorallPeriod),
                            side: MaterialStateProperty.all(BorderSide(color: AppColors.white)),
                          ),
                          onPressed: () => controller.allPeriodTransactions(),
                          child: Text(
                            'Todos os períodos',
                            style: GoogleFonts.notoSans(
                              fontSize: 12.0,
                              color: controller.buttonTextColorAllPeriod,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(controller.buttonBackgroundColorCurrentPeriod),
                            side: MaterialStateProperty.all(BorderSide(color: AppColors.white)),
                          ),
                          onPressed: () => controller.currentPeriodTransactions(),
                          child: Text(
                            'Período Atual',
                            style: GoogleFonts.notoSans(
                              fontSize: 12.0,
                              color: controller.buttonTextColorCurrentPeriod,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(controller.buttonBackgroundColorFuturePeriod),
                            side: MaterialStateProperty.all(BorderSide(color: AppColors.white)),
                          ),
                          onPressed: () => controller.futurePeriodTransactions(),
                          child: Text(
                            'Períodos Futuros',
                            style: GoogleFonts.notoSans(
                              fontSize: 12.0,
                              color: controller.buttonTextColorFuturePeriod,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
