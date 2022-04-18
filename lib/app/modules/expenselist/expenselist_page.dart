import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
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
        appBar: AppBar(
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
        body: controller.expenseList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: controller.expenseList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTile(
                        trailing: Text('R\$ ' + controller.expenseList[index].value!.toStringAsFixed(2)),
                        title: Text(controller.expenseList[index].description!),
                        subtitle: Text(DateFormat('dd/MM/yyyy').format(controller.expenseList[index].date)),
                        onTap: () {
                          Get.toNamed(Routes.EXPENSE_UPDATE, arguments: {
                            'user': controller.user,
                            'expenseId': controller.expenseList[index].id!,
                            'expenseValue': controller.expenseList[index].value!,
                            'expenseValueTextFormController': controller.expenseList[index].value!.toStringAsFixed(2),
                            'workedCost': controller.workedCost(controller.expenseList[index].value!),
                            'dateUpdateTextController': TextEditingController(text: DateFormat('dd/MM/yyyy').format(controller.expenseList[index].date)),
                            'newSelectedDate': controller.expenseList[index].date,
                            'pay': controller.expenseList[index].pay!,
                            'updatePay': controller.expenseList[index].pay!,
                            'descriptionTextController': TextEditingController(text: controller.expenseList[index].description!),
                            'selectedCategory': controller.expenseList[index].category!,
                            'selectedExpenseQuality': controller.expenseList[index].quality!,
                            'addInformationTextController': TextEditingController(text: controller.expenseList[index].addInformation!),
                          });
                        },
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Apagar',
                        color: AppColors.expenseColor,
                        icon: Icons.delete,
                        onTap: () {
                          controller.expenseId = controller.expenseList[index].id!;
                          controller.expenseDescription = controller.expenseList[index].description!;
                          controller.expenseValue = controller.expenseList[index].value!;
                          controller.expensePay = controller.expenseList[index].pay!;
                          controller.deleteExpense();
                        },
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  'Não há despesas cadastradas',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
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
