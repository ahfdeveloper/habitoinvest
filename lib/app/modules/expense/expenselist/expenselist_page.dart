import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_controller.dart';
import 'package:habito_invest_app/app/modules/expense/expenseupdate/expenseupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';
import '../../../global/constants.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/app_text_styles.dart';

class ExpenseList extends StatelessWidget {
  final ExpenseListController _expenseListController = Get.find<ExpenseListController>();
  final ExpenseUpdateController _expenseUpdateController = Get.put(ExpenseUpdateController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.expenseColor,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
          title: _expenseListController.searchBoolean == false
              ? Text('Despesas')
              : TextFormField(
                  controller: _expenseListController.searchFormFieldController,
                  style: AppTextStyles.appBarTextLight,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Descrição da receita',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => _expenseListController.runFilter(value),
                ),
          actions: [
            // Determina qual botão vai aparece no appBar de acordo com a ação do usuário
            _expenseListController.searchBoolean == false
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _expenseListController.searchBoolean = true,
                  )
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _expenseListController.searchBoolean = false;
                      _expenseListController.expenseList = _expenseListController.result;
                    },
                  ),
          ],
        ),
        body: _expenseListController.expenseList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: _expenseListController.expenseList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTile(
                        trailing: Text('R\$ ' + _expenseListController.expenseList[index].value!.toStringAsFixed(2)),
                        title: Text(_expenseListController.expenseList[index].description!),
                        subtitle: Text(DateFormat('dd/MM/yyyy').format(_expenseListController.expenseList[index].date)),
                        onTap: () {
                          _expenseUpdateController.expenseValue = _expenseListController.expenseList[index].value!;
                          _expenseUpdateController.expenseValueTextFormController.text = _expenseListController.expenseList[index].value!.toStringAsFixed(2);
                          _expenseUpdateController.workedCost(_expenseListController.expenseList[index].value!.toStringAsFixed(2));
                          _expenseUpdateController.dateUpdateTextController =
                              TextEditingController(text: DateFormat('dd/MM/yyyy').format(_expenseListController.expenseList[index].date));
                          _expenseUpdateController.newSelectedDate = _expenseListController.expenseList[index].date;
                          _expenseUpdateController.expenseId = _expenseListController.expenseList[index].id!;
                          _expenseUpdateController.pay = _expenseListController.expenseList[index].pay!;
                          _expenseUpdateController.updatePay = _expenseListController.expenseList[index].pay!;
                          _expenseUpdateController.descriptionTextController?.text = _expenseListController.expenseList[index].description!;
                          _expenseUpdateController.selectedCategory = _expenseListController.expenseList[index].category!;
                          _expenseUpdateController.selectedExpenseQuality = _expenseListController.expenseList[index].quality!;
                          _expenseUpdateController.addInformationTextController?.text = _expenseListController.expenseList[index].addInformation!;
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
                          _expenseListController.expenseId = _expenseListController.expenseList[index].id!;
                          _expenseListController.expenseDescription = _expenseListController.expenseList[index].description!;
                          _expenseListController.expenseValue = _expenseListController.expenseList[index].value!;
                          _expenseListController.expensePay = _expenseListController.expenseList[index].pay!;
                          _expenseListController.deleteExpense();
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
            Get.toNamed(Routes.EXPENSE_ADD, arguments: _expenseListController.user);
          },
          backgroundColor: AppColors.expenseColor,
          tooltip: 'Nova Despesa',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
