import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/transactionsreportlist/transactionsreportlist_controller.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../global_widgets/app_listtile_widget.dart';

class TransactionsReportListPage extends GetView<TransactionsReportListController> {
  const TransactionsReportListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.themeColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
        title: Text('Relatório de Transações', style: AppTextStyles.appBarTextLight),
      ),
      body: Obx(
        () => controller.incomeList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: controller.incomeList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTileWidget(
                        titleName: controller.incomeList[index].description!,
                        date: controller.incomeList[index].date,
                        value: controller.incomeList[index].value!,
                        color: controller.colorReceived(controller.incomeList[index].received!)!,
                        onTap: () => {}),
                  );
                },
              )
            : controller.expenseList.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.all(2.0),
                    itemCount: controller.expenseList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTileWidget(
                            titleName: controller.expenseList[index].description!,
                            date: controller.expenseList[index].date,
                            value: controller.expenseList[index].value!,
                            color: controller.colorReceived(controller.expenseList[index].pay!)!,
                            onTap: () => {}),
                      );
                    },
                  )
                : controller.investmentList.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.all(2.0),
                        itemCount: controller.investmentList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTileWidget(
                                titleName: controller.investmentList[index].description!,
                                date: controller.investmentList[index].date,
                                value: controller.investmentList[index].value!,
                                color: controller.colorReceived(controller.investmentList[index].madeEffective!)!,
                                onTap: () => {}),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Transações não encontradas',
                          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                      ),
      ),
    );
  }
}
