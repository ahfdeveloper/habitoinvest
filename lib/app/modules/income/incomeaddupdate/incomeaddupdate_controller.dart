import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';

import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:intl/intl.dart';

class IncomeAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final IncomeRepository _incomeRepository = IncomeRepository();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final AccountRepository _accountRepository = AccountRepository();

  // Máscara para digitação do valor da receita ------------------------------------
  MoneyMaskedTextController incomeValueTextFormController = moneyValueController;

  // Definição de valor inicial para o campo de data da Receita
  TextEditingController dateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  TextEditingController? descriptionTextController;
  TextEditingController? addInformationTextController;

  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField
   de seleção da categoria de receita -----------------------------------------------*/
  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categoriesList => _categoriesList.value;
  String firstElementDrop = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  // Variável usada para definição se receita foi recebida ou não
  RxBool _received = false.obs;
  bool get received => this._received.value;
  set received(bool value) => this._received.value = value;

// Variável usada para definição se receita foi recebida ou não
  RxBool _updateReceived = false.obs;
  bool get updateReceived => this._updateReceived.value;
  set updateReceived(bool value) => this._updateReceived.value = value;

  double _incomeValue = 0.0;
  double get incomeValue => this._incomeValue;
  set incomeValue(double value) => this._incomeValue = value;

  // Guarda e recupera o Id da receita
  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  // Variável que guarda a descrição da receita para exibição na snackbar
  String _incomeDescription = '';
  String get incomeDescription => this._incomeDescription;
  set incomeDescription(String value) => this._incomeDescription = value;

  // Variável informativa que mostra dado a ser digitado no TextFormField
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

  String _addEditFlag = '';
  String get addEditFlag => this._addEditFlag;
  set addEditFlag(String value) => this._addEditFlag = value;

  DateTime _newSelectedDate = DateTime.now();
  DateTime get newSelectedDate => this._newSelectedDate;
  set newSelectedDate(DateTime value) => this._newSelectedDate = value;

  var accountId;
  @override
  void onInit() {
    _categoriesList.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    descriptionTextController = TextEditingController();
    incomeValueTextFormController = moneyValueController;
    addInformationTextController = TextEditingController();
    super.onInit();
  }

  // Pegar data selecionada no Date Picker e setar textformfield de data
  selectDate(BuildContext context) async {
    newSelectedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.from(
            colorScheme: ColorScheme.light(primary: AppColors.incomeColor),
          ),
          child: child!,
        );
      },
    ))!;
    dateTextController
      ..text = DateFormat('dd/MM/yyyy').format(newSelectedDate)
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: dateTextController.text.length, affinity: TextAffinity.upstream),
      );
  }

  /* Função que retorna apenas as categorias do tipo receita para preenchimento
   do DropdownbuttonFormField ------------------------------------------------*/
  List<String> selectIncomeCategory() {
    List<String> listCategoryIncome = [firstElementDrop];
    categoriesList.forEach((item) {
      if (item.type == 'Receita') {
        listCategoryIncome.add(item.name!);
      }
    });
    return listCategoryIncome;
  }

  // Efetua o salvamento de uma nova receita ou de uma receita editada
  void saveUpdateIncome({required String addEditFlag}) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (descriptionTextController!.text != '' && selectedCategory != selectIncomeCategory().first) {
        incomeDescription = descriptionTextController!.text;
        // Se receita marcada como recebida atualiza saldo do usuário
        if (updateReceived == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! + incomeValueTextFormController.numberValue,
            accValueLT: incomeValueTextFormController.numberValue,
            accTypeLT: 'Income',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        }
        _incomeRepository
            .addIncome(
              userUid: user!.id,
              incValue: incomeValueTextFormController.numberValue,
              incReceived: updateReceived,
              incDate: newSelectedDate,
              incDescription: descriptionTextController!.text,
              incCategory: selectedCategory,
              incAddInformation: addInformationTextController!.text,
            )
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                title: incomeDescription,
                message: 'Receita cadastrada com sucesso',
              ),
            );
        clearEditingControllers();
        Get.back();
      }

      // TENHO QUE FAZER VARIAVEL DE VALOR E VALOR VELHO
    } else if (addEditFlag == 'UPDATE') {
      if (descriptionTextController!.text != '' && selectedCategory != selectIncomeCategory().first) {
        incomeDescription = descriptionTextController!.text;
        if (received == false && updateReceived == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! + incomeValueTextFormController.numberValue,
            accValueLT: incomeValueTextFormController.numberValue,
            accTypeLT: 'Update Income',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        } else if (received == true && updateReceived == false) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! - incomeValue,
            accValueLT: incomeValueTextFormController.numberValue,
            accTypeLT: 'Update Income',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        } else if (received == true && updateReceived == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! - incomeValue + incomeValueTextFormController.numberValue,
            accValueLT: incomeValueTextFormController.numberValue,
            accTypeLT: 'Update Income',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        } else if (received == false && updateReceived == false) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance!,
            accValueLT: incomeValueTextFormController.numberValue,
            accTypeLT: 'Update Income',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        }
        _incomeRepository
            .updateIncome(
                userUid: user!.id,
                incValue: incomeValueTextFormController.numberValue,
                incReceived: updateReceived,
                incDate: newSelectedDate,
                incDescription: descriptionTextController!.text,
                incCategory: selectedCategory,
                incAddInformation: addInformationTextController!.text,
                incUid: incomeId)
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                title: incomeDescription,
                message: 'Receita atualizada com sucesso',
              ),
            );
        clearEditingControllers();
        Get.back();
      }
    }
  }

  // Limpa os campos do formulário
  void clearEditingControllers() {
    moneyValueController.updateValue(0.0);
    descriptionTextController!.clear();
    selectedCategory = firstElementDrop;
    addInformationTextController!.clear();
  }

  // Cancela o cadastro ou edição de uma nova receita
  void cancel() {
    clearEditingControllers();
    Get.back();
  }
}
