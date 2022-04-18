import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_masks.dart';
import '../../data/model/account_model.dart';
import '../../data/model/category_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/account_repository.dart';
import '../../data/service/category_repository.dart';
import '../../data/service/income_repository.dart';
import '../../global_widgets/app_snackbar.dart';
import '../../routes/routes.dart';

////// PASSAR TUDO EM FORMA DE ARGUMENTOS, TROCAR STATELESS POR GETVIEW E ELIMINAR INSTANCIAÇÕES DE CONTROLLERS DESNECESSÁRIOS.
//// RESOLVER PAU DO DROPDOWN

class IncomeAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final IncomeRepository _incomeRepository = IncomeRepository();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final AccountRepository _accountRepository = AccountRepository();

  // Máscara para digitação do valor da receita
  MoneyMaskedTextController incomeValueTextFormController = moneyValueController;

  // Definição de valor inicial para o campo de data da Receita
  TextEditingController dateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  // Campos que recebem os dados de descrição e informações adicionais da receita
  TextEditingController descriptionTextController = TextEditingController(text: '');
  TextEditingController addInformationTextController = TextEditingController(text: '');

  // Lista que recebe os dados da conta do usuário
  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField
   de seleção da categoria de receita */
  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categoriesList => _categoriesList.value;
  String firstElementDrop = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  // Flag que indica se se trata de uma nova receita ou outra em edição
  String _addEditFlag = '';
  String get addEditFlag => this._addEditFlag;
  set addEditFlag(String value) => this._addEditFlag = value;

  // Guarda Id da receita para atualização dos dados
  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  // Variável que recupera se receita foi recebida ou não quando de sua edição
  RxBool _received = false.obs;
  bool get received => this._received.value;
  set received(bool value) => this._received.value = value;

  // Variável usada para definição se receita foi recebida ou não
  RxBool _updateReceived = true.obs;
  bool get updateReceived => this._updateReceived.value;
  set updateReceived(bool value) => this._updateReceived.value = value;

  // Variável informativa que mostra dado a ser digitado no TextFormField (Hint do TextFormField)
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

  // Variável que guarda valor da receita que está em edição para atualizar o saldo da conta
  double _incomeValue = 0.0;
  double get incomeValue => this._incomeValue;
  set incomeValue(double value) => this._incomeValue = value;

  // Variável que guarda a descrição da receita para exibição na snackbar
  String _incomeDescription = '';
  String get incomeDescription => this._incomeDescription;
  set incomeDescription(String value) => this._incomeDescription = value;

  // Guarda a data escolhida pelo usuário no Data Picker
  DateTime _newSelectedDate = DateTime.now();
  DateTime get newSelectedDate => this._newSelectedDate;
  set newSelectedDate(DateTime value) => this._newSelectedDate = value;

  @override
  void onInit() {
    _categoriesList.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    addEditFlag = Get.arguments['addEditFlag'];
    if (addEditFlag == 'UPDATE') {
      incomeId = Get.arguments['incomeId'];
      incomeValue = Get.arguments['incomeValue'];
      newSelectedDate = Get.arguments['newSelectedDate'];
      incomeValueTextFormController.text = Get.arguments['incomeValueTextFormController'];
      dateTextController = Get.arguments['dateTextController'];
      descriptionTextController = Get.arguments['descriptionTextController'];
      received = Get.arguments['received'];
      updateReceived = Get.arguments['updateReceived'];
      selectedCategory = Get.arguments['selectedCategory'];
      addInformationTextController = Get.arguments['addInformationTextController'];
    }
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
  Future<void> saveUpdateIncome({required String addEditFlag}) async {
    print(incomeId);
    print(addEditFlag);
    print(user!.name);
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      Get.defaultDialog(
        titleStyle: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
        title: 'Novo Investimento',
        content: Text(
          'Esse é o momento ideal para investir. Vamos lá? ',
          textAlign: TextAlign.center,
        ),
        buttonColor: AppColors.themeColor,
        textCancel: 'Salvar e investir depois',
        cancelTextColor: AppColors.themeColor,
        textConfirm: 'Salvar e investir',
        confirmTextColor: AppColors.white,
        onConfirm: () {
          if (descriptionTextController.text != '' && selectedCategory != selectIncomeCategory().first) {
            incomeDescription = descriptionTextController.text;
            Get.back();
            // Se receita marcada como recebida, atualiza saldo do usuário
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
            _incomeRepository.addIncome(
                userUid: user!.id,
                incValue: incomeValueTextFormController.numberValue,
                incReceived: updateReceived,
                incDate: newSelectedDate,
                incDescription: descriptionTextController.text,
                incCategory: selectedCategory,
                incAddInformation: addInformationTextController.text)
              ..whenComplete(() {
                FocusManager.instance.primaryFocus?.unfocus();
                AppSnackbar.snackarStyle(title: incomeDescription, message: 'Receita cadastrada com sucesso');
                clearEditingControllers();
                Future.delayed(Duration(milliseconds: 1200), () {
                  Get.offAndToNamed(Routes.INVESTMENT_ADDUPDATE, arguments: user);
                });
              });
          }
        },
        onCancel: () {
          if (descriptionTextController.text != '' && selectedCategory != selectIncomeCategory().first) {
            incomeDescription = descriptionTextController.text;
            // Se receita marcada como recebida, atualiza saldo do usuário
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
            _incomeRepository.addIncome(
                userUid: user!.id,
                incValue: incomeValueTextFormController.numberValue,
                incReceived: updateReceived,
                incDate: newSelectedDate,
                incDescription: descriptionTextController.text,
                incCategory: selectedCategory,
                incAddInformation: addInformationTextController.text)
              ..whenComplete(() {
                FocusManager.instance.primaryFocus?.unfocus();
                AppSnackbar.snackarStyle(title: incomeDescription, message: 'Receita cadastrada com sucesso');
                clearEditingControllers();
              });
            Get.back();
          }
        },
      );
    } else if (addEditFlag == 'UPDATE') {
      if (descriptionTextController.text != '' && selectedCategory != selectIncomeCategory().first) {
        incomeDescription = descriptionTextController.text;
        /* Sequencia de if que define quando o saldo da conta deve ser atualizado dependendo se a receita foi marcada
        como recebida ou não */
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
        _incomeRepository.updateIncome(
          userUid: user!.id,
          incValue: incomeValueTextFormController.numberValue,
          incReceived: updateReceived,
          incDate: newSelectedDate,
          incDescription: descriptionTextController.text,
          incCategory: selectedCategory,
          incAddInformation: addInformationTextController.text,
          incUid: incomeId,
        )..whenComplete(
            () {
              AppSnackbar.snackarStyle(title: incomeDescription, message: 'Receita atualizada com sucesso');
              clearEditingControllers();
            },
          );
        Get.back();
      }
    }
  }

  // Limpa os campos do formulário
  void clearEditingControllers() async {
    moneyValueController.updateValue(0.0);
    dateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    descriptionTextController.clear();
    selectedCategory = firstElementDrop;
    addInformationTextController.clear();
  }

  // Cancela o cadastro ou edição de uma nova receita
  void cancel() {
    clearEditingControllers();
    Get.back();
  }
}
