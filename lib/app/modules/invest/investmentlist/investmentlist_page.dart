import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/modules/invest/investaddupdate/investmentaddupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:intl/intl.dart';

import 'investmentlist_controller.dart';

class InvestmentList extends StatelessWidget {
  final InvestmentListController _investmentListController =
      Get.find<InvestmentListController>();

  final InvestmentAddUpdateController _investmentAddUpdateController =
      Get.put(InvestmentAddUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Investimentos'),
        backgroundColor: AppColors.investcolor,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(2.0),
          itemCount: _investmentListController.investmentList.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionExtentRatio: 0.25,
              actionPane: SlidableDrawerActionPane(),
              child: Card(
                child: ListTile(
                  trailing: Text('R\$ ' +
                      _investmentListController.investmentList[index].value!
                          .toStringAsFixed(2)),
                  title: Text(_investmentListController
                      .investmentList[index].description!),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(
                      _investmentListController.investmentList[index].date)),
                  onTap: () {
                    _investmentAddUpdateController.addEditFlag = 'UPDATE';
                    _investmentAddUpdateController.investmentId =
                        _investmentListController.investmentList[index].id!;
                    _investmentAddUpdateController
                            .investmentValueTextFormController.text =
                        _investmentListController.investmentList[index].value!
                            .toStringAsFixed(2);
                    _investmentAddUpdateController.madeEffective =
                        _investmentListController
                            .investmentList[index].madeEffective!;
                    _investmentAddUpdateController.dateTextController =
                        TextEditingController(
                            text: DateFormat('dd/MM/yyyy').format(
                                _investmentListController
                                    .investmentList[index].date));
                    _investmentAddUpdateController
                            .descriptionTextController?.text =
                        _investmentListController
                            .investmentList[index].description!;
                    _investmentAddUpdateController
                            .addInformationTextController?.text =
                        _investmentListController
                            .investmentList[index].addInformation!;
                    Get.toNamed(Routes.INVESTMENT_ADDUPDATE,
                        arguments: _investmentListController.user);
                  },
                ),
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Apagar',
                  color: AppColors.expenseColor,
                  icon: Icons.delete,
                  onTap: () {
                    _investmentListController.investmentId =
                        _investmentListController.investmentList[index].id!;
                    _investmentListController.investmentDescription =
                        _investmentListController
                            .investmentList[index].description!;
                    _investmentListController.deleteInvestment();
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _investmentAddUpdateController.addEditFlag = 'NEW';
          _investmentAddUpdateController.dateTextController =
              TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
          _investmentAddUpdateController.newSelectedDate = DateTime.now();
          _investmentAddUpdateController.descriptionValue = 'Descrição';
          _investmentAddUpdateController.investmentValueTextFormController =
              MoneyMaskedTextController(leftSymbol: 'R\$ ');
          _investmentAddUpdateController.madeEffective = false;
          Get.toNamed(Routes.INVESTMENT_ADDUPDATE,
              arguments: _investmentListController.user);
        },
        backgroundColor: AppColors.investcolor,
        tooltip: 'Novo Investimento',
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
