import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';

class IncomeList extends StatelessWidget {
  final IncomeListController _incomeListController = Get.put(IncomeListController());
  final IncomeAddUpdateController _incomeAddUpdateController = Get.find<IncomeAddUpdateController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.incomeColor,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
          title: _incomeListController.searchBoolean == false
              ? Text(
                  'Receitas',
                  style: AppTextStyles.appBarTextLight,
                )
              : TextFormField(
                  controller: _incomeListController.searchFormFieldController,
                  style: AppTextStyles.appBarTextLight,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Descrição da receita',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => _incomeListController.runFilter(value),
                ),
          actions: [
            // Determina qual botão vai aparece no appBar de acordo com a ação do usuário
            _incomeListController.searchBoolean == false
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _incomeListController.searchBoolean = true,
                  )
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _incomeListController.searchBoolean = false;
                      _incomeListController.incomeList = _incomeListController.result;
                    },
                  ),
          ],
        ),
        body: _incomeListController.incomeList.isNotEmpty
            ? ListView.builder(
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
                          _incomeAddUpdateController.dateTextController =
                              TextEditingController(text: DateFormat('dd/MM/yyyy').format(_incomeListController.incomeList[index].date));
                          _incomeAddUpdateController.newSelectedDate = _incomeListController.incomeList[index].date;
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
                          _incomeListController.incomeReceived = _incomeListController.incomeList[index].received!;
                          _incomeListController.deleteIncome();
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
            _incomeAddUpdateController.addEditFlag = 'NEW';
            moneyValueController.updateValue(0.0);
            Get.toNamed(Routes.INCOME_ADDUPDATE, arguments: _incomeListController.user);
          },
          backgroundColor: AppColors.incomeColor,
          tooltip: 'Nova Receita',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
