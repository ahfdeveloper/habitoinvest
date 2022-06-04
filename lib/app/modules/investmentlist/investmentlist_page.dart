import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_masks.dart';
import '../../global_widgets/app_listtile_widget.dart';
import '../../routes/routes.dart';
import 'investmentlist_controller.dart';

class InvestmentList extends GetView<InvestmentListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.investColor,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
          title: controller.searchBoolean == false
              ? Text('Investimentos')
              : TextFormField(
                  controller: controller.searchFormFieldController,
                  style: AppTextStyles.appBarTextLight,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Descrição do investimento',
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
                      controller.investmentList = controller.result;
                      controller.searchFormFieldController.clear();
                    },
                  ),
          ],
        ),
        body: controller.investmentList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: controller.investmentList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTileWidget(
                        titleName: controller.investmentList[index].description!,
                        date: controller.investmentList[index].date,
                        value: controller.investmentList[index].value!,
                        color: controller.colorEffective(controller.investmentList[index].madeEffective!)!,
                        onTap: () => Get.toNamed(
                          Routes.INVESTMENT_ADDUPDATE,
                          arguments: {
                            'user': controller.user,
                            'title': 'Atualizar Investimento',
                            'addEditFlag': 'UPDATE',
                            'investmentId': controller.investmentList[index].id!,
                            'investimentValue': controller.investmentList[index].value!,
                            'investmentValueTextFormController': controller.investmentList[index].value!.toStringAsFixed(2),
                            'effective': controller.investmentList[index].madeEffective!,
                            'updateEffective': controller.investmentList[index].madeEffective!,
                            'dateTextController': TextEditingController(text: DateFormat('dd/MM/yyyy').format(controller.investmentList[index].date)),
                            'newSelectedDate': controller.investmentList[index].date,
                            'descriptionTextController': TextEditingController(text: controller.investmentList[index].description!),
                            'addInformationTextController': TextEditingController(text: controller.investmentList[index].addInformation!),
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
                          controller.investmentId = controller.investmentList[index].id!;
                          controller.investmentDescription = controller.investmentList[index].description!;
                          controller.investmentValue = controller.investmentList[index].value!;
                          controller.investmentMadeEffective = controller.investmentList[index].madeEffective!;
                          controller.deleteInvestment();
                        },
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  'Não há investimentos cadastrados',
                  style: AppTextStyles.messageEmptyList,
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            moneyValueController.updateValue(0.0);
            Get.toNamed(
              Routes.INVESTMENT_ADDUPDATE,
              arguments: {
                'user': controller.user,
                'addEditFlag': 'NEW',
              },
            );
          },
          backgroundColor: AppColors.investColor,
          tooltip: 'Novo Investimento',
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
