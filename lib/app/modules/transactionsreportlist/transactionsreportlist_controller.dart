import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/model/investment_model.dart';
import 'package:habito_invest_app/app/data/service/expense_repository.dart';
import 'package:habito_invest_app/app/data/service/income_repository.dart';
import 'package:habito_invest_app/app/data/service/investment_repository.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/income_model.dart';
import '../../data/model/user_model.dart';

class TransactionsReportListController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final IncomeRepository _incomeRepository = IncomeRepository();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final InvestmentRepository _investmentRepository = InvestmentRepository();

  Rx<List<IncomeModel>> _incomeList = Rx<List<IncomeModel>>([]);
  List<IncomeModel> get incomeList => this._incomeList.value;
  set incomeList(List<IncomeModel> value) => this._incomeList.value = value;

  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expenseList => this._expenseList.value;
  set expenseList(List<ExpenseModel> value) => this._expenseList.value = value;

  Rx<List<InvestmentModel>> _investmentList = Rx<List<InvestmentModel>>([]);
  List<InvestmentModel> get investmentList => this._investmentList.value;
  set investmentList(List<InvestmentModel> value) => this._investmentList.value = value;

  // Guarda o tipo de transação escolhido pelo usuário
  String _transactionType = '';
  String get transactionType => this._transactionType;
  set transactionType(String value) => this._transactionType = value;

  // Guarda a categoria escolhida pelo usuário
  String _category = '';
  String get category => this._category;
  set category(String value) => this._category = value;

  // Guarda a qualidade da despesa escolhida pelo usuário
  String _expenseQuality = '';
  String get expenseQuality => this._expenseQuality;
  set expenseQuality(String value) => this._expenseQuality = value;

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
    expenseQuality = Get.arguments['expenseQuality'];
    initialDate = Get.arguments['initialDate'];
    endDate = Get.arguments['endDate'];
    switch (transactionType) {
      case 'Receita':
        return searchIncomeTransactions();
      case 'Despesa':
        return searchExpenseTransactions();
      case 'Investimento':
        return searchInvestmentTransactions();
    }

    super.onInit();
  }

  searchIncomeTransactions() async {
    if (category == 'Todos') {
      _incomeList.bindStream(
        _incomeRepository.getAllIncomePeriod(
          userUid: user!.id,
          initialDate: initialDate,
          endDate: endDate,
        ),
      );
    } else {
      _incomeList.bindStream(
        _incomeRepository.getIncomePeriodWithCategory(
          userUid: user!.id,
          category: category,
          initialDate: initialDate,
          endDate: endDate,
        ),
      );
    }
  }

  searchExpenseTransactions() {
    if (category == 'Todos') {
      if (expenseQuality == 'Todos') {
        _expenseList.bindStream(
          _expenseRepository.getAllExpensePeriod(
            userUid: user!.id,
            initialDate: initialDate,
            endDate: endDate,
          ),
        );
      } else {
        _expenseList.bindStream(
          _expenseRepository.getExpensePeriodWithQuality(
            userUid: user!.id,
            expenseQuality: expenseQuality,
            initialDate: initialDate,
            endDate: endDate,
          ),
        );
      }
    } else {
      if (expenseQuality == 'Todos') {
        _expenseList.bindStream(
          _expenseRepository.getExpensePeriodWithCategory(
            userUid: user!.id,
            category: category,
            initialDate: initialDate,
            endDate: endDate,
          ),
        );
      } else {
        _expenseList.bindStream(
          _expenseRepository.getExpensePeriodWithCategQuality(
            userUid: user!.id,
            category: category,
            expenseQuality: expenseQuality,
            initialDate: initialDate,
            endDate: endDate,
          ),
        );
      }
    }
  }

  searchInvestmentTransactions() {
    _investmentList.bindStream(
      _investmentRepository.getAllInvestmentPeriod(
        userUid: user!.id,
        initialDate: initialDate,
        endDate: endDate,
      ),
    );
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
