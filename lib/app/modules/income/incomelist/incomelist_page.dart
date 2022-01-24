import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class IncomeList extends StatelessWidget {
  final IncomeListController _incomeListController = Get.find<IncomeListController>();
  final IncomeAddUpdateController _incomeAddUpdateController = Get.put(IncomeAddUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Receitas'),
        backgroundColor: AppColors.incomeColor,
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(2.0),
          itemCount: _incomeListController.incomeList.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionExtentRatio: 0.25,
              actionPane: SlidableDrawerActionPane(),
              child: Card(
                child: ListTile(
                  trailing: Text('R\$ ' + _incomeListController.incomeList[index].value!.toStringAsFixed(2)),
                  title: Text(_incomeListController.incomeList[index].description!),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(_incomeListController.incomeList[index].date)),
                  onTap: () {
                    _incomeAddUpdateController.addEditFlag = 'UPDATE';
                    _incomeAddUpdateController.incomeId = _incomeListController.incomeList[index].id!;
                    _incomeAddUpdateController.incomeValue = _incomeListController.incomeList[index].value!;
                    _incomeAddUpdateController.incomeValueTextFormController.text = _incomeListController.incomeList[index].value!.toStringAsFixed(2);
                    _incomeAddUpdateController.received = _incomeListController.incomeList[index].received!;
                    _incomeAddUpdateController.updateReceived = _incomeListController.incomeList[index].received!;
                    _incomeAddUpdateController.dateTextController = TextEditingController(
                      text: DateFormat('dd/MM/yyyy').format(_incomeListController.incomeList[index].date),
                    );
                    _incomeAddUpdateController.descriptionTextController?.text = _incomeListController.incomeList[index].description!;
                    _incomeAddUpdateController.selectedCategory = _incomeListController.incomeList[index].category!;
                    _incomeAddUpdateController.addInformationTextController?.text = _incomeListController.incomeList[index].addInformation!;
                    Get.toNamed(Routes.INCOME_ADDUPDATE, arguments: _incomeListController.user);
                  },
                ),
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Apagar',
                  color: AppColors.expenseColor,
                  icon: Icons.delete,
                  onTap: () {
                    _incomeListController.incomeId = _incomeListController.incomeList[index].id!;
                    _incomeListController.incomeDescription = _incomeListController.incomeList[index].description!;
                    _incomeListController.incomeValue = _incomeListController.incomeList[index].value!;
                    _incomeListController.deleteIncome();
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _incomeAddUpdateController.addEditFlag = 'NEW';
          moneyValueController.updateValue(0.0);
          _incomeAddUpdateController.dateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
          _incomeAddUpdateController.newSelectedDate = DateTime.now();
          _incomeAddUpdateController.descriptionValue = 'Descrição';
          _incomeAddUpdateController.received = false;
          Get.toNamed(Routes.INCOME_ADDUPDATE, arguments: _incomeListController.user);
        },
        backgroundColor: AppColors.incomeColor,
        tooltip: 'Nova Receita',
        child: Icon(Icons.add),
      ),
    );
  }
}
