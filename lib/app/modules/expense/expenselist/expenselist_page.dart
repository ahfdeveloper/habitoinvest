import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
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
        body: ListView.builder(
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
                    _expenseUpdateController.dateTextController =
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
                    _expenseListController.deleteExpense();
                  },
                ),
              ],
            );
          },
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
      ),
    );
  }
}
