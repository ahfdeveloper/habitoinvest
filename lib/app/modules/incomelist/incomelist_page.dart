import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_masks.dart';
import '../../routes/routes.dart';
import 'incomelist_controller.dart';

class IncomeList extends GetView<IncomeListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.incomeColor,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
          title: controller.searchBoolean == false
              ? Text(
                  'Receitas',
                  style: AppTextStyles.appBarTextLight,
                )
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
                      controller.incomeList = controller.result;
                      controller.searchFormFieldController.clear();
                    },
                  ),
          ],
        ),
        body: controller.incomeList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: controller.incomeList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTile(
                        trailing: Text('R\$ ' + controller.incomeList[index].value!.toStringAsFixed(2)),
                        title: Text(controller.incomeList[index].description!),
                        subtitle: Text(DateFormat('dd/MM/yyyy').format(controller.incomeList[index].date)),
                        onTap: () {
                          Get.toNamed(
                            Routes.INCOME_ADDUPDATE,
                            arguments: {
                              'user': controller.user,
                              'addEditFlag': 'UPDATE',
                              'incomeId': controller.incomeList[index].id!,
                              'incomeValue': controller.incomeList[index].value!,
                              'incomeValueTextFormController': controller.incomeList[index].value!.toStringAsFixed(2),
                              'received': controller.incomeList[index].received!,
                              'updateReceived': controller.incomeList[index].received!,
                              'dateTextController': TextEditingController(text: DateFormat('dd/MM/yyyy').format(controller.incomeList[index].date)),
                              'newSelectedDate': controller.incomeList[index].date,
                              'descriptionTextController': TextEditingController(text: controller.incomeList[index].description!),
                              'selectedCategory': controller.incomeList[index].category!,
                              'addInformationTextController': TextEditingController(text: controller.incomeList[index].addInformation!),
                            },
                          );
                        },
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Apagar',
                        color: AppColors.expenseColor,
                        icon: Icons.delete,
                        onTap: () {
                          controller.incomeId = controller.incomeList[index].id!;
                          controller.incomeDescription = controller.incomeList[index].description!;
                          controller.incomeValue = controller.incomeList[index].value!;
                          controller.incomeReceived = controller.incomeList[index].received!;
                          controller.deleteIncome();
                        },
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  'Não há receitas cadastradas',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            moneyValueController.updateValue(0.0);
            Get.toNamed(
              Routes.INCOME_ADDUPDATE,
              arguments: {
                'user': controller.user,
                'addEditFlag': 'NEW',
              },
            );
          },
          backgroundColor: AppColors.incomeColor,
          tooltip: 'Nova Receita',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
