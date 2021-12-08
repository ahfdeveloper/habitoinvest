import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final ExpenseListController _expenseListController =
      Get.find<ExpenseListController>();

  final ExpenseAddUpdateController _expenseAddUpdateController =
      Get.put(ExpenseAddUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Despesas'),
        backgroundColor: AppColors.expenseColor,
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(2.0),
          itemCount: _expenseListController.expense.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionExtentRatio: 0.25,
              actionPane: SlidableDrawerActionPane(),
              child: Card(
                child: ListTile(
                  trailing: Text('R\$ ' +
                      _expenseListController.expense[index].totalValue!
                          .toStringAsFixed(2)),
                  title:
                      Text(_expenseListController.expense[index].description!),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(
                      _expenseListController
                          .expense[index].datePayFirstPortion!)),
                  onTap: () {
                    // _incomeAddUpdateController.addEditFlag = 'UPDATE';
                    // _incomeAddUpdateController.incomeId =
                    //     _incomeListController.income[index].id!;
                    // _incomeAddUpdateController.nameTextController?.text =
                    //     _incomeListController.income[index].name!;
                    // _incomeAddUpdateController.selectedCategory =
                    //     _incomeListController.income[index].category!;
                    // _incomeAddUpdateController.valueTextController?.text =
                    //     _incomeListController.income[index].value.toString();
                    // _incomeAddUpdateController.observationTextController?.text =
                    //     _incomeListController.income[index].observation!;
                    // Get.toNamed(Routes.INCOME_ADDUPDATE,
                    //     arguments: _incomeListController.user);
                  },
                ),
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Apagar',
                  color: AppColors.expenseColor,
                  icon: Icons.delete,
                  onTap: () {
                    // _incomeListController.incomeId =
                    //     _incomeListController.income[index].id!;
                    // _incomeListController.incomeName =
                    //     _incomeListController.income[index].name!;
                    // _incomeListController.deleteIncome();
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _expenseAddUpdateController.addEditFlag = 'NEW';
          _expenseAddUpdateController.visibilityInstallmentsYes = false;
          _expenseAddUpdateController.visibilityInstallmentsNo = false;
          _expenseAddUpdateController.containerRadioNaoColor = null;
          _expenseAddUpdateController.containerRadioSimColor = null;
          _expenseAddUpdateController.installmentsType = '';
          _expenseAddUpdateController.descriptionValue = 'Descrição';

          Get.toNamed(
            Routes.EXPENSE_ADDUPDATE,
            arguments: _expenseListController.user,
          );
        },
        backgroundColor: AppColors.expenseColor,
        tooltip: 'Nova Despesa',
        child: Icon(Icons.add),
      ),
    );
  }
}
