import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles/app_text_styles.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'investmentlist_controller.dart';

class InvestmentList extends StatelessWidget {
  final InvestmentListController _investmentListController = Get.find<InvestmentListController>();
  final InvestmentAddUpdateController _investmentAddUpdateController = Get.put(InvestmentAddUpdateController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.investColor,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
          title: _investmentListController.searchBoolean == false
              ? Text('Investimentos')
              : TextFormField(
                  controller: _investmentListController.searchFormFieldController,
                  style: AppTextStyles.appBarTextLight,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Descrição do investimento',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => _investmentListController.runFilter(value),
                ),
          actions: [
            // Determina qual botão vai aparece no appBar de acordo com a ação do usuário
            _investmentListController.searchBoolean == false
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _investmentListController.searchBoolean = true,
                  )
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _investmentListController.searchBoolean = false;
                      _investmentListController.investmentList = _investmentListController.result;
                    },
                  ),
          ],
        ),
        body: _investmentListController.investmentList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: _investmentListController.investmentList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTile(
                        trailing: Text('R\$ ' + _investmentListController.investmentList[index].value!.toStringAsFixed(2)),
                        title: Text(_investmentListController.investmentList[index].description!),
                        subtitle: Text(DateFormat('dd/MM/yyyy').format(_investmentListController.investmentList[index].date)),
                        onTap: () {
                          _investmentAddUpdateController.title = 'Atualizar Investimento';
                          _investmentAddUpdateController.addEditFlag = 'UPDATE';
                          _investmentAddUpdateController.investmentId = _investmentListController.investmentList[index].id!;
                          _investmentAddUpdateController.investimentValue = _investmentListController.investmentList[index].value!;
                          _investmentAddUpdateController.investmentValueTextFormController.text =
                              _investmentListController.investmentList[index].value!.toStringAsFixed(2);
                          _investmentAddUpdateController.effective = _investmentListController.investmentList[index].madeEffective!;
                          _investmentAddUpdateController.updateEffective = _investmentListController.investmentList[index].madeEffective!;
                          _investmentAddUpdateController.dateTextController =
                              TextEditingController(text: DateFormat('dd/MM/yyyy').format(_investmentListController.investmentList[index].date));
                          _investmentAddUpdateController.newSelectedDate = _investmentListController.investmentList[index].date;
                          _investmentAddUpdateController.descriptionTextController?.text = _investmentListController.investmentList[index].description!;
                          _investmentAddUpdateController.addInformationTextController?.text = _investmentListController.investmentList[index].addInformation!;
                          Get.toNamed(Routes.INVESTMENT_ADDUPDATE, arguments: _investmentListController.user);
                        },
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Apagar',
                        color: AppColors.expenseColor,
                        icon: Icons.delete,
                        onTap: () {
                          _investmentListController.investmentId = _investmentListController.investmentList[index].id!;
                          _investmentListController.investmentDescription = _investmentListController.investmentList[index].description!;
                          _investmentListController.investmentValue = _investmentListController.investmentList[index].value!;
                          _investmentListController.investmentMadeEffective = _investmentListController.investmentList[index].madeEffective!;
                          _investmentListController.deleteInvestment();
                        },
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  'Não há investimentos cadastrados',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            moneyValueController.updateValue(0.0);
            _investmentAddUpdateController.addEditFlag = 'NEW';
            Get.toNamed(Routes.INVESTMENT_ADDUPDATE, arguments: _investmentListController.user);
          },
          backgroundColor: AppColors.investColor,
          tooltip: 'Novo Investimento',
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
