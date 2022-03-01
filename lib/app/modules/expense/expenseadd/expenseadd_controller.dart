import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/parameters_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';
import 'package:habito_invest_app/app/data/repository/parameters_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ExpenseAddController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final AccountRepository _accountRepository = AccountRepository();
  final ParametersRepository _parametersRepository = ParametersRepository();

  // Máscara para digitação do valor da despesa
  MoneyMaskedTextController expenseValueTextFormFieldController = moneyValueController;

  // Formato de exibição de data no campo de data da despesa
  TextEditingController dateExpenseTextFormFieldController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  TextEditingController? descriptionTextController;
  TextEditingController? qtPortionTextController;
  TextEditingController? addInformationTextController;

  // Data de compra a ser setada quando da atualização ou cadastro de nova despesa
  late DateTime _date = DateTime.now();
  DateTime get date => this._date;
  set date(DateTime value) => this._date = value;

  // Carrega o registro que mantém saldo da conta do usuário
  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  // Carrega o registro que mantém saldo da conta do usuário
  Rx<List<ParametersModel>> _parametersList = Rx<List<ParametersModel>>([]);
  List<ParametersModel> get parametersList => _parametersList.value;

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField de 
  seleção da categoria de despesa ------------------------------------------------------*/
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

  // Variáveis utilizadas para escolha se despesa é parcelada ou não
  RxString _installmentsType = ''.obs;
  String get installmentsType => this._installmentsType.value;
  set installmentsType(String value) => this._installmentsType.value = value;

  // Variáveis usadas para exibir informações quando o usuário escolhe se a despesa é parcelada ou não
  bool _visibilityInstallmentsNo = false;
  bool get visibilityInstallmentsNo => this._visibilityInstallmentsNo;
  set visibilityInstallmentsNo(bool value) => this._visibilityInstallmentsNo = value;
  bool _visibilityInstallmentsYes = false;
  bool get visibilityInstallmentsYes => this._visibilityInstallmentsYes;
  set visibilityInstallmentsYes(bool value) => this._visibilityInstallmentsYes = value;

  // Variáveis usadas para definir a cor do container de acordo com escolha se despesa é parcelada ou não
  Color? _containerRadioSimColor;
  Color? get containerRadioSimColor => this._containerRadioSimColor;
  set containerRadioSimColor(Color? value) => this._containerRadioSimColor = value;
  Color? _containerRadioNaoColor;
  Color? get containerRadioNaoColor => this._containerRadioNaoColor;
  set containerRadioNaoColor(Color? value) => this._containerRadioNaoColor = value;

  // Armzena quantidade de horas de trabalho equivalente a despesa
  RxDouble _workedHours = 0.0.obs;
  double get workedHours => this._workedHours.value;
  set workedHours(double value) => this._workedHours.value = value;

  // Variável informativa que mostra dado a serr digitado no TextFormField
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

  // Variável usada para definição se despesa foi paga ou não
  RxBool _pay = false.obs;
  bool get pay => this._pay.value;
  set pay(bool value) => this._pay.value = value;

  // Variável que guarda a descrição da despesa para exibição na snackbar
  String _expenseDescription = '';
  String get expenseDescription => this._expenseDescription;
  set expenseDescription(String value) => this._expenseDescription = value;

  // Guarda e recupera o Id da despesa
  String _expenseId = '';
  String get expenseId => this._expenseId;
  set expenseId(String value) => this._expenseId = value;

  @override
  void onInit() {
    _categoriesList.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    _parametersList.bindStream(_parametersRepository.getAllParameters(userUid: user!.id));
    expenseValueTextFormFieldController = moneyValueController;
    descriptionTextController = TextEditingController();
    qtPortionTextController = TextEditingController();
    addInformationTextController = TextEditingController();
    super.onInit();
  }

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDate({required BuildContext context, required TextEditingController textFormFieldController}) async {
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.from(colorScheme: ColorScheme.light(primary: AppColors.expenseColor)),
            child: child!,
          );
        }) as DateTime;
    textFormFieldController
      ..text = DateFormat('dd/MM/yyyy').format(date)
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: textFormFieldController.text.length, affinity: TextAffinity.upstream),
      );
  }

  // Efetua o salvamento de uma nova despesa ou de uma despesa editada
  Future<void> saveExpense() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (descriptionTextController!.text != '' && selectedCategory != selectExpenseCategory().first) {
      expenseDescription = descriptionTextController!.text;
      bool pg = pay;
      DateTime data = date;

      if (installmentsType == 'Sim' && qtPortionTextController!.text != '') {
        for (int i = int.parse(qtPortionTextController!.text); i >= 1; i--) {
          if (i != 1) {
            pay = false;
            date = Jiffy(data).add(months: i - 1).dateTime;
          } else {
            pay = pg;
            date = data;
          }
          // Se despesa marcada como paga atualiza saldo da conta
          if (pay == true) {
            _accountRepository.updateAccount(
              userUid: user!.id,
              accBalance: _accountList.value.first.balance! - (expenseValueTextFormFieldController.numberValue / int.parse(qtPortionTextController!.text)),
              accValueLT: expenseValueTextFormFieldController.numberValue / int.parse(qtPortionTextController!.text),
              accTypeLT: 'New Expense',
              accDateLT: date,
              accUid: _accountList.value.first.id!,
            );
          }
          _expenseRepository.addExpense(
            userUid: user!.id,
            expValue: expenseValueTextFormFieldController.numberValue / int.parse(qtPortionTextController!.text),
            expDate: date,
            expDescription: descriptionTextController!.text + ' ($i/${qtPortionTextController!.text})',
            expCategory: selectedCategory,
            expQuality: selectedExpenseQuality,
            expPay: pay,
            expAddInformation: addInformationTextController!.text,
          )..whenComplete(
              () {
                FocusManager.instance.primaryFocus?.unfocus();
                AppSnackbar.snackarStyle(title: expenseDescription, message: 'Despesa cadastrado com sucesso');
                clearEditingControllers();
                Get.back();
              },
            );
        }
      } else if (installmentsType == 'Não') {
        if (pay == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! - expenseValueTextFormFieldController.numberValue,
            accValueLT: expenseValueTextFormFieldController.numberValue,
            accTypeLT: 'New Expense',
            accDateLT: date,
            accUid: _accountList.value.first.id!,
          );
        }
        _expenseRepository.addExpense(
          userUid: user!.id,
          expValue: expenseValueTextFormFieldController.numberValue,
          expDate: date,
          expDescription: descriptionTextController!.text,
          expCategory: selectedCategory,
          expQuality: selectedExpenseQuality,
          expPay: pay,
          expAddInformation: addInformationTextController!.text,
        )..whenComplete(() {
            FocusManager.instance.primaryFocus?.unfocus();
            AppSnackbar.snackarStyle(title: expenseDescription, message: 'Despesa cadastrado com sucesso');
            clearEditingControllers();
          });
        Get.back();
      }
    }
  }

  // Estima o valor da despesa em horas de trabalho
  workedCost(value) async {
    value = expenseValueTextFormFieldController.numberValue;
    if (parametersList.first.workedHours != 0) {
      double monthHours = parametersList.first.workedHours! * 4.5;
      workedHours = value / (parametersList.first.salary! / monthHours);
    }
  }

  // Retorna apenas as categorias do tipo despesa para preenchimento do DropdownbuttonFormField
  List<String> selectExpenseCategory() {
    List<String> listCategoryExpense = [firstElementDrop];
    categories.forEach((item) {
      if (item.type == 'Despesa') {
        listCategoryExpense.add(item.name!);
      }
    });
    return listCategoryExpense;
  }

  // Muda a cor do container com escolha de despesa parcelada ou não
  void paintContainerType() {
    if (installmentsType == 'Sim') {
      containerRadioSimColor = AppColors.grey300;
      containerRadioNaoColor = null;
    } else if (installmentsType == 'Não') {
      containerRadioSimColor = null;
      containerRadioNaoColor = AppColors.grey300;
    } else {
      containerRadioSimColor = null;
      containerRadioNaoColor = null;
    }
  }

  // Limpa os campos do formulário
  void clearEditingControllers() {
    descriptionTextController!.clear();
    selectedCategory = firstElementDrop;
    selectedExpenseQuality = 'Essencial';
    moneyValueController.updateValue(0.0);
    addInformationTextController!.clear();
    installmentsType = '';
    workedHours = 0.0;
  }
}
