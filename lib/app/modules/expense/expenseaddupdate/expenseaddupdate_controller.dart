import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:intl/intl.dart';

class ExpenseAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final ExpenseRepository _expenseRepository = ExpenseRepository();
  final CategoryRepository _categoriesRepository = CategoryRepository();

  // Máscara para digitação do valor da despesa ------------------------------------
  MoneyMaskedTextController expenseValueTextFormFieldController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');

  TextEditingController dateShopTextFormFieldController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  TextEditingController datePortionTextFormFieldController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  TextEditingController dateNoPortionFormFieldController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  TextEditingController? descriptionTextController;
  TextEditingController? qtdePortionTextController;
  TextEditingController? dayPayPortionTextController;
  TextEditingController? addInformationTextController;

  /* Flag para indicar se o form foi aberto para cadastro de uma nova despesa
  ou para edição de uma despesa existente ----------------------------------*/
  String _addEditFlag = '';
  String get addEditFlag => this._addEditFlag;
  set addEditFlag(String value) => this._addEditFlag = value;

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField
   de seleção da categoria de despesa -----------------------------------------------*/
  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categories => _categoriesList.value;
  String firstElementDrop = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  // Itens constantes no DropDownFormField de qualidade da despesa
  final List expenseQualityList = [
    'Essencial',
    'Não essencial, mas importante',
    'Não essencial'
  ];
  final _selectedExpenseQuality = 'Essencial'.obs;
  String get selectedExpenseQuality => this._selectedExpenseQuality.value;
  set selectedExpenseQuality(String value) =>
      this._selectedExpenseQuality.value = value;

  // Variáveis utilizadas para escolha se despesa é parcelada ou não
  RxString _installmentsType = ''.obs;
  String get installmentsType => this._installmentsType.value;
  set installmentsType(String value) {
    _installmentsType.update((val) {
      _installmentsType.value = value;
    });
  }

  // Data de compra a ser setada quando da atualização ou cadastro de nova despesa
  late DateTime _dateShop = DateTime.now();
  DateTime get dateShop => this._dateShop;
  set dateShop(DateTime value) => this._dateShop = value;

  /* Data de pagamento da primeira parcela quando despesa parcelada ou parcela única quando despesa 
  não parcelada a ser setada quando da atualização ou cadastro de nova despesa --------------------*/
  DateTime _datePayFirstPortion = DateTime.now();
  DateTime get datePayFirstPortion => this._datePayFirstPortion;
  set datePayFirstPortion(DateTime value) => this._datePayFirstPortion = value;

  // Variáveis usadas para exibir informações quando o usuário escolhe se a despesa é parcelada ou não
  bool _visibilityInstallmentsNo = false;
  bool get visibilityInstallmentsNo => this._visibilityInstallmentsNo;
  set visibilityInstallmentsNo(bool value) =>
      this._visibilityInstallmentsNo = value;
  bool _visibilityInstallmentsYes = false;
  bool get visibilityInstallmentsYes => this._visibilityInstallmentsYes;
  set visibilityInstallmentsYes(bool value) =>
      this._visibilityInstallmentsYes = value;

  // Variáveis usadas para definir a cor do container de acordo com escolha se despesa é parcelada ou não
  Color? _containerRadioSimColor;
  Color? get containerRadioSimColor => this._containerRadioSimColor;
  set containerRadioSimColor(Color? value) =>
      this._containerRadioSimColor = value;
  Color? _containerRadioNaoColor;
  Color? get containerRadioNaoColor => this._containerRadioNaoColor;
  set containerRadioNaoColor(Color? value) =>
      this._containerRadioNaoColor = value;

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

  @override
  void onInit() {
    _categoriesList.bindStream(
      _categoriesRepository.getAllCategories(userUid: user!.id),
    );
    expenseValueTextFormFieldController =
        MoneyMaskedTextController(leftSymbol: 'R\$ ');
    descriptionTextController = TextEditingController();
    qtdePortionTextController = TextEditingController();
    dayPayPortionTextController = TextEditingController();
    addInformationTextController = TextEditingController();
    super.onInit();
  }

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDateShop(
      {required BuildContext context,
      required TextEditingController textFormFieldController}) async {
    dateShop = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.from(
                  colorScheme:
                      ColorScheme.light(primary: AppColors.expenseColor)),
              child: child!);
        }) as DateTime;
    textFormFieldController
      ..text = DateFormat('dd/MM/yyyy').format(dateShop)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: textFormFieldController.text.length,
          affinity: TextAffinity.upstream));
  }

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDatePortion(
      {required BuildContext context,
      required TextEditingController textFormFieldController}) async {
    datePayFirstPortion = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.from(
                  colorScheme:
                      ColorScheme.light(primary: AppColors.expenseColor)),
              child: child!);
        }) as DateTime;
    textFormFieldController
      ..text = DateFormat('dd/MM/yyyy').format(datePayFirstPortion)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: textFormFieldController.text.length,
          affinity: TextAffinity.upstream));
  }

  // Efetua o salvamento de uma nova despesa ou de uma despesa editada
  void saveUpdateExpense({required String addEditFlag}) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (expenseValueTextFormFieldController.text != '' &&
          descriptionTextController!.text != '' &&
          selectedCategory != selectIncomeCategory().first &&
          installmentsType != '') {
        expenseDescription = descriptionTextController!.text;
        if (installmentsType == 'Sim' &&
            qtdePortionTextController!.text != '' &&
            dayPayPortionTextController!.text != '' &&
            installmentsType != '') {
          _expenseRepository.addExpense(
            userUid: user!.id,
            expTotalValue: expenseValueTextFormFieldController.numberValue,
            expPay: pay,
            expDateShop: dateShop,
            expDescription: descriptionTextController!.text,
            expCategory: selectedCategory,
            expQuality: selectedExpenseQuality,
            expDatePayFirstPortion: datePayFirstPortion,
            expPortionNumber: qtdePortionTextController!.text,
            expTotalPortionNumber: '',
            expPortionValue: expenseValueTextFormFieldController.numberValue,
            expAddInformation: addInformationTextController!.text,
          );
          clearEditingControllers();
        } else if (installmentsType == 'Não') {
          _expenseRepository.addExpense(
            userUid: user!.id,
            expTotalValue: expenseValueTextFormFieldController.numberValue,
            expPay: pay,
            expDateShop: dateShop,
            expDescription: descriptionTextController!.text,
            expCategory: selectedCategory,
            expQuality: selectedExpenseQuality,
            expDatePayFirstPortion: datePayFirstPortion,
            expPortionNumber: qtdePortionTextController!.text,
            expTotalPortionNumber: '',
            expPortionValue: expenseValueTextFormFieldController.numberValue,
            expAddInformation: addInformationTextController!.text,
          );
          clearEditingControllers();
        }

        //         .addIncome(
        //           userUid: user!.id,
        //           incDate: newSelectedDate,
        //           incName: nameTextController!.text,
        //           incCategory: selectedCategory,
        //           incValue: double.parse(valueTextController!.text),
        //           incObservation: addInformationTextController!.text,
        //         )
        //         .whenComplete(
        //           () => AppSnackbar.snackarStyle(
        //             title: incomeName,
        //             message: 'Receita cadastrada com sucesso',
        //           ),
        //         );
        //     clearEditingControllers();
        //     Get.back();
        //   }
        // } else if (addEditFlag == 'UPDATE') {
        //   if (nameTextController!.text != '' &&
        //       selectedCategory != selectIncomeCategory().first &&
        //       valueTextController!.text != '' &&
        //       addInformationTextController!.text != '') {
        //     incomeName = nameTextController!.text;
        //     _incomeRepository.updateIncome(
        //         userUid: user!.id,
        //         incDate: newSelectedDate,
        //         incName: nameTextController!.text,
        //         incCategory: selectedCategory,
        //         incValue: double.parse(valueTextController!.text),
        //         incObservation: addInformationTextController!.text,
        //         incUid: incomeId)
        //       ..whenComplete(
        //         () => AppSnackbar.snackarStyle(
        //           title: incomeName,
        //           message: 'Receita atualizada com sucesso',
        //         ),
        //       );
        //     clearEditingControllers();
        Get.back();
      }
    }
  }

  /* Função que retorna apenas as categorias do tipo despesa para preenchimento
   do DropdownbuttonFormField -------------------------------------------------*/
  List<String> selectIncomeCategory() {
    List<String> listCategoryIncome = [firstElementDrop];
    categories.forEach((item) {
      if (item.type == 'Despesa') {
        listCategoryIncome.add(item.name!);
      }
    });
    return listCategoryIncome;
  }

  // Muda a cor do container com escolha de despesa parcelada ou não.
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
    expenseValueTextFormFieldController =
        MoneyMaskedTextController(leftSymbol: 'R\$ ');
    addInformationTextController!.clear();
    installmentsType = '';
  }

  // Cancela o cadastro ou edição de uma nova receita
  void cancel() {
    clearEditingControllers();
    Get.back();
  }
}
