import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global_widgets/app_listtile_widget.dart';
import 'package:habito_invest_app/app/modules/expenselist/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_masks.dart';
import '../../routes/routes.dart';
import 'expenselist_controller.dart';

class ExpenseList extends GetView<ExpenseListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBarWidget(controller: controller),
        body: Container(
          child: controller.expenseMainList.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.all(2.0),
                  itemCount: controller.expenseMainList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionExtentRatio: 0.25,
                      actionPane: SlidableDrawerActionPane(),
                      child: Card(
                        child: ListTileWidget(
                          titleName: controller.expenseMainList[index].description!,
                          date: controller.expenseMainList[index].date,
                          value: controller.expenseMainList[index].value!,
                          color: controller.colorPay(controller.expenseMainList[index].pay!)!,
                          onTap: () => Get.toNamed(
                            Routes.EXPENSE_UPDATE,
                            arguments: {
                              'user': controller.user,
                              'expenseId': controller.expenseMainList[index].id!,
                              'expenseValue': controller.expenseMainList[index].value!,
                              'expenseValueTextFormController': controller.expenseMainList[index].value!.toStringAsFixed(2),
                              'workedCost': controller.workedCost(controller.expenseMainList[index].value!),
                              'dateUpdateTextController': TextEditingController(text: DateFormat('dd/MM/yyyy').format(controller.expenseMainList[index].date)),
                              'newSelectedDate': controller.expenseMainList[index].date,
                              'pay': controller.expenseMainList[index].pay!,
                              'updatePay': controller.expenseMainList[index].pay!,
                              'descriptionTextController': TextEditingController(text: controller.expenseMainList[index].description!),
                              'selectedCategory': controller.expenseMainList[index].category!,
                              'selectedExpenseQuality': controller.expenseMainList[index].quality!,
                              'addInformationTextController': TextEditingController(text: controller.expenseMainList[index].addInformation!),
                            },
                          ),
                        ),
                      ),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Apagar',
                          color: AppColors.expenseColor,
                          icon: Icons.delete,
                          onTap: () {
                            controller.expenseId = controller.expenseMainList[index].id!;
                            controller.expenseDescription = controller.expenseMainList[index].description!;
                            controller.expenseValue = controller.expenseMainList[index].value!;
                            controller.expensePay = controller.expenseMainList[index].pay!;
                            controller.deleteExpense();
                          },
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Não há despesas cadastradas para o período',
                    style: AppTextStyles.messageEmptyList,
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            moneyValueController.updateValue(0.0);
            Get.toNamed(Routes.EXPENSE_ADD, arguments: {'user': controller.user});
          },
          backgroundColor: AppColors.expenseColor,
          tooltip: 'Nova Despesa',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
