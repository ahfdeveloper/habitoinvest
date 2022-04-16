import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_masks.dart';
import '../../data/model/account_model.dart';
import '../../data/model/category_model.dart';
import '../../data/model/parameters_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/category_repository.dart';
import '../../data/service/expense_repository.dart';
import '../../data/service/parameters_repository.dart';
import '../../global_widgets/app_snackbar.dart';

class ExpenseUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();

  // Máscara para digitação do valor da despesa
  MoneyMaskedTextController expenseValueTextFormController = moneyValueController;

  // Formato de exibição de data no campo de data da despesa
  TextEditingController dateUpdateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  // Controllers dos campos de descrição e Informações adicionais
  TextEditingController? descriptionTextController;
  TextEditingController? addInformationTextController;

  // Variável que guarda valor da despesa que está em edição para atualizar o saldo da conta
  double _expenseValue = 0.0;
  double get expenseValue => this._expenseValue;
  set expenseValue(double value) => this._expenseValue = value;

  // Guarda e recupera o Id da despesa
  String _expenseId = '';
  String get expenseId => this._expenseId;
  set expenseId(String value) => this._expenseId = value;

  // Armzena quantidade de horas de trabalho equivalente a despesa
  RxDouble _workedHours = 0.0.obs;
  double get workedHours => this._workedHours.value;
  set workedHours(double value) => this._workedHours.value = value;

  // Variável informativa que mostra dado a ser digitado no TextFormField
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

  // Carrega o registro que mantém saldo da conta do usuário
  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  // Carrega o registro que mantém saldo da conta do usuário
  Rx<List<ParametersModel>> _parametersList = Rx<List<ParametersModel>>([]);
  List<ParametersModel> get parametersList => _parametersList.value;

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField de 
  seleção da categoria de despesa --------------------------------------------------------*/
  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categories => _categoriesList.value;
  String firstElementDrop = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  // Itens constantes no DropDownFormField de qualidade da despesa
  final List expenseQualityList = ['Essencial', 'Não essencial, mas importante', 'Não essencial'];
  RxString _selectedExpenseQuality = 'Essencial'.obs;
  String get selectedExpenseQuality => this._selectedExpenseQuality.value;
  set selectedExpenseQuality(String value) => this._selectedExpenseQuality.value = value;

  // Variável que recebe informação se receita em edição está paga ou não
  RxBool _pay = false.obs;
  bool get pay => this._pay.value;
  set pay(bool value) => this._pay.value = value;

  // Variável usada para definição se despesa foi paga ou não
  RxBool _updatePay = false.obs;
  bool get updatePay => this._updatePay.value;
  set updatePay(bool value) => this._updatePay.value = value;

  // Variável que guarda a descrição da despesa para exibição na snackbar
  String _expenseDescription = '';
  String get expenseDescription => this._expenseDescription;
  set expenseDescription(String value) => this._expenseDescription = value;

  // Data da despesa a ser setada quando da atualização ou cadastro de nova despesa
  late DateTime _newSelectedDate = DateTime.now();
  DateTime get newSelectedDate => this._newSelectedDate;
  set newSelectedDate(DateTime value) => this._newSelectedDate = value;

  @override
  void onInit() {
    _categoriesList.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    _parametersList.bindStream(_parametersRepository.getAllParameters(userUid: user!.id));
    expenseValueTextFormController = moneyValueController;
    descriptionTextController = TextEditingController();
    addInformationTextController = TextEditingController();
    super.onInit();
  }

  workedCost(value) async {
    value = expenseValueTextFormController.numberValue;
    if (parametersList.first.workedHours != 0) {
      double monthHours = parametersList.first.workedHours! * 4.5;
      workedHours = value / (parametersList.first.salary! / monthHours);
    }
  }

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDate({required BuildContext context, required TextEditingController textFormFieldController}) async {
    newSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(data: ThemeData.from(colorScheme: ColorScheme.light(primary: AppColors.expenseColor)), child: child!);
        }) as DateTime;
    textFormFieldController
      ..text = DateFormat('dd/MM/yyyy').format(newSelectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(offset: textFormFieldController.text.length, affinity: TextAffinity.upstream));
  }

  Future<void> updateExpense() async {
    if (descriptionTextController!.text != '' && selectedCategory != selectExpenseCategory().first) {
      expenseDescription = descriptionTextController!.text;

      /* Sequencia de if que define quando o saldo da conta deve ser atualizado dependendo se a despesa foi marcada
        como recebida ou não ---------------------------------------------------------------------------------------*/
      if (pay == false && updatePay == true) {
        _accountRepository.updateAccount(
          userUid: user!.id,
          accBalance: _accountList.value.first.balance! - expenseValueTextFormController.numberValue,
          accValueLT: expenseValueTextFormController.numberValue,
          accTypeLT: 'Update Expense',
          accDateLT: newSelectedDate,
          accUid: _accountList.value.first.id!,
        );
      } else if (pay == true && updatePay == false) {
        _accountRepository.updateAccount(
          userUid: user!.id,
          accBalance: _accountList.value.first.balance! + expenseValue,
          accValueLT: expenseValueTextFormController.numberValue,
          accTypeLT: 'Update Expense',
          accDateLT: newSelectedDate,
          accUid: _accountList.value.first.id!,
        );
      } else if (pay == true && updatePay == true) {
        _accountRepository.updateAccount(
          userUid: user!.id,
          accBalance: _accountList.value.first.balance! + expenseValue - expenseValueTextFormController.numberValue,
          accValueLT: expenseValueTextFormController.numberValue,
          accTypeLT: 'Update Expense',
          accDateLT: newSelectedDate,
          accUid: _accountList.value.first.id!,
        );
      } else if (pay == false && updatePay == false) {
        _accountRepository.updateAccount(
          userUid: user!.id,
          accBalance: _accountList.value.first.balance!,
          accValueLT: expenseValueTextFormController.numberValue,
          accTypeLT: 'Update Expense',
          accDateLT: newSelectedDate,
          accUid: _accountList.value.first.id!,
        );
      }

      _expenseRepository.updateExpense(
        userUid: user!.id,
        expValue: expenseValueTextFormController.numberValue,
        expDate: newSelectedDate,
        expDescription: descriptionTextController!.text,
        expCategory: selectedCategory,
        expQuality: selectedExpenseQuality,
        expPay: updatePay,
        expAddInformation: addInformationTextController!.text,
        expUid: expenseId,
      )..whenComplete(() {
          FocusManager.instance.primaryFocus?.unfocus();
          AppSnackbar.snackarStyle(title: expenseDescription, message: 'Despesa atualizada com sucesso');
          clearEditingControllers();
        });
      Get.back();
    }
  }

  // Função que retorna apenas as categorias do tipo despesa para preenchimento do DropdownbuttonFormField
  List<String> selectExpenseCategory() {
    List<String> listCategoryExpense = [firstElementDrop];
    categories.forEach((item) {
      if (item.type == 'Despesa') {
        listCategoryExpense.add(item.name!);
      }
    });
    return listCategoryExpense;
  }

  // Limpa os campos do formulário
  void clearEditingControllers() {
    moneyValueController.updateValue(0.0);
    formkey.currentState!.reset();
    dateUpdateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    descriptionTextController!.clear();
    selectedCategory = firstElementDrop;
    selectedExpenseQuality = 'Essencial';
    addInformationTextController!.clear();
    workedHours = 0.0;
  }
}
