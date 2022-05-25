import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/service/income_repository.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/income_model.dart';
import '../../data/model/user_model.dart';

class TransactionsReportListController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final IncomeRepository _incomeRepository = IncomeRepository();

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeList => this._incomeList.value;
  set incomeList(List<IncomeModel> value) => this._incomeList.value = value;

  // Variável que guarda o tipo de transação escolhido
  String _transactionType = '';
  String get transactionType => this._transactionType;
  set transactionType(String value) => this._transactionType = value;

  // Variável que guarda a categoria escolhida
  String _category = '';
  String get category => this._category;
  set category(String value) => this._category = value;

// Guarda a data escolhida pelo usuário no Data Picker data inicial
  DateTime _initialDate = DateTime.now();
  DateTime get initialDate => this._initialDate;
  set initialDate(DateTime value) => this._initialDate = value;

  // Guarda a data escolhida pelo usuário no Data Picker data final
  DateTime _endDate = DateTime.now();
  DateTime get endDate => this._endDate;
  set endDate(DateTime value) => this._endDate = value;

  @override
  void onInit() {
    transactionType = Get.arguments['transactionType'];
    category = Get.arguments['category'];
    initialDate = Get.arguments['initialDate'];
    endDate = Get.arguments['endDate'];
    searchTransactions();
    super.onInit();
  }

  searchTransactions() async {
    if (transactionType == 'Receita' && category != 'Todos') {
      _incomeList.bindStream(
        _incomeRepository.getAllIncomePeriod(
          userUid: user!.id,
          //category: category,
          initialDate: initialDate,
          endDate: endDate,
        ),
      );
    }
  }

  // Faz a mudança de cor do indicador de recebido ou não no ListTile
  Color? colorReceived(bool received) {
    if (received == true) {
      return AppColors.incomeColor;
    } else {
      return AppColors.grey400;
    }
  }
}

/* abstract class ListItem {
  Widget buildCard(BuildContext context);
}

class IncomeItem implements ListItem {
  final IncomeModel income;
  IncomeItem(this.income);

  @override
  Widget buildCard(BuildContext context) {
    return Card(
      child: ListTileWidget(
        titleName: income.description!,
        date: income.date,
        value: income.value!,
        color: colorReceived(income.received!)!,
        onTap: () => {},
      ),
    );
  }
}

class ExpenseItem implements ListItem {
  final ExpenseModel expense;
  ExpenseItem(this.expense);

  @override
  Widget buildCard(BuildContext context) {
    return Card(
      child: ListTileWidget(
        titleName: expense.description!,
        date: expense.date,
        value: expense.value!,
        color: colorPay(expense.pay!)!,
        onTap: () => null,
      ),
    );
  }
}

class InvestimentItem implements ListItem {
  final InvestmentModel investiment;
  InvestimentItem(this.investiment);

  @override
  Widget buildCard(BuildContext context) {
    return Card(
      child: ListTileWidget(
        titleName: investiment.description!,
        date: investiment.date,
        value: investiment.value!,
        color: colorEffective(investiment.madeEffective!)!,
        onTap: () => null,
      ),
    );
  }
}

//  repetido aqui e nos controller, se funcionar ver como fazer
Color? colorReceived(bool received) {
  if (received == true) {
    return AppColors.incomeColor;
  } else {
    return AppColors.grey400;
  }
}

Color? colorPay(bool pay) {
  if (pay == true) {
    return AppColors.expenseColor;
  } else {
    return AppColors.grey400;
  }
}

// Faz a mudança de cor do indicador de efetivado ou não no ListTile
Color? colorEffective(bool effective) {
  if (effective == true) {
    return AppColors.investColor;
  } else {
    return AppColors.grey400;
  }
} */
