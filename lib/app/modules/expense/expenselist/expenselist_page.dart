import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/expense/expenseadd/expenseadd_controller.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_controller.dart';
import 'package:habito_invest_app/app/modules/expense/expenseupdate/expenseupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final ExpenseListController _expenseListController = Get.find<ExpenseListController>();
  final ExpenseAddController _expenseAddController = Get.put(ExpenseAddController());
  final ExpenseUpdateController _expenseUpdateController = Get.put(ExpenseUpdateController());

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
                  trailing: Text('R\$ ' + _expenseListController.expense[index].value!.toStringAsFixed(2)),
                  title: Text(_expenseListController.expense[index].description!),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(_expenseListController.expense[index].date)),
                  onTap: () {
                    _expenseUpdateController.expenseValue = _expenseListController.expense[index].value!;
                    _expenseUpdateController.expenseValueTextFormController.text = _expenseListController.expense[index].value!.toStringAsFixed(2);
                    _expenseUpdateController.workedCost(_expenseListController.expense[index].value!.toStringAsFixed(2));
                    _expenseUpdateController.dateTextController =
                        TextEditingController(text: DateFormat('dd/MM/yyyy').format(_expenseListController.expense[index].date));
                    _expenseUpdateController.newSelectedDate = _expenseListController.expense[index].date;
                    _expenseUpdateController.expenseId = _expenseListController.expense[index].id!;
                    _expenseUpdateController.pay = _expenseListController.expense[index].pay!;
                    _expenseUpdateController.updatePay = _expenseListController.expense[index].pay!;
                    _expenseUpdateController.descriptionTextController?.text = _expenseListController.expense[index].description!;
                    _expenseUpdateController.selectedCategory = _expenseListController.expense[index].category!;
                    _expenseUpdateController.selectedExpenseQuality = _expenseListController.expense[index].quality!;
                    _expenseUpdateController.addInformationTextController?.text = _expenseListController.expense[index].addInformation!;
                    Get.toNamed(Routes.EXPENSE_UPDATE, arguments: _expenseListController.user);
                  },
                ),
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Apagar',
                  color: AppColors.expenseColor,
                  icon: Icons.delete,
                  onTap: () {
                    _expenseListController.expenseId = _expenseListController.expense[index].id!;
                    _expenseListController.expenseDescription = _expenseListController.expense[index].description!;
                    _expenseListController.deleteExpense();
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _expenseAddController.dateExpenseTextFormFieldController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
          _expenseAddController.visibilityInstallmentsYes = false;
          _expenseAddController.visibilityInstallmentsNo = true;
          _expenseAddController.containerRadioNaoColor = null;
          _expenseAddController.containerRadioSimColor = null;
          _expenseAddController.selectedExpenseQuality = 'Essencial';
          _expenseAddController.installmentsType = 'Não';
          _expenseAddController.paintContainerType();
          _expenseAddController.pay = true;
          _expenseAddController.descriptionValue = 'Descrição';
          _expenseAddController.expenseValueTextFormFieldController = moneyValueController;
          _expenseAddController.qtPortionTextController!.text = '';

          Get.toNamed(
            Routes.EXPENSE_ADD,
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
