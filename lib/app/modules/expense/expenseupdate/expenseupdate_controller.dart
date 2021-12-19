import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar.dart';
import 'package:intl/intl.dart';

class ExpenseUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  // Máscara para digitação do valor da despesa ------------------------------------
  MoneyMaskedTextController expenseValueTextFormFieldController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');

  // Formato de exibição de data no campo de data da despesa
  TextEditingController dateTextController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  // Controllers dos campos de descrição e Informações adicionais
  TextEditingController? descriptionTextController;
  TextEditingController? addInformationTextController;

  // Guarda e recupera o Id da despesa
  String _expenseId = '';
  String get expenseId => this._expenseId;
  set expenseId(String value) => this._expenseId = value;

  // Variável informativa que mostra dado a ser digitado no TextFormField
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

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
  RxString _selectedExpenseQuality = 'Essencial'.obs;
  String get selectedExpenseQuality => this._selectedExpenseQuality.value;
  set selectedExpenseQuality(String value) =>
      this._selectedExpenseQuality.value = value;

  // Variável usada para definição se despesa foi paga ou não
  RxBool _pay = false.obs;
  bool get pay => this._pay.value;
  set pay(bool value) => this._pay.value = value;

  // Variável que guarda a descrição da despesa para exibição na snackbar
  String _expenseDescription = '';
  String get expenseDescription => this._expenseDescription;
  set expenseDescription(String value) => this._expenseDescription = value;

  // Data da despesa a ser setada quando da atualização ou cadastro de nova despesa
  late DateTime _date = DateTime.now();
  DateTime get date => this._date;
  set date(DateTime value) => this._date = value;

  @override
  void onInit() {
    _categoriesList.bindStream(
      _categoriesRepository.getAllCategories(userUid: user!.id),
    );
    expenseValueTextFormFieldController =
        MoneyMaskedTextController(leftSymbol: 'R\$ ');
    descriptionTextController = TextEditingController();
    addInformationTextController = TextEditingController();
    super.onInit();
  }

  // Pegar data selecionada no Date Picker e setar textformfield
  selectDate(
      {required BuildContext context,
      required TextEditingController textFormFieldController}) async {
    date = await showDatePicker(
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
      ..text = DateFormat('dd/MM/yyyy').format(date)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: textFormFieldController.text.length,
          affinity: TextAffinity.upstream));
  }

  void updateExpense() {
    if (descriptionTextController!.text != '' &&
        selectedCategory != selectExpenseCategory().first) {
      expenseDescription = descriptionTextController!.text;
      _expenseRepository.updateExpense(
          userUid: user!.id,
          expValue: expenseValueTextFormFieldController.numberValue,
          expDate: date,
          expDescription: descriptionTextController!.text,
          expCategory: selectedCategory,
          expQuality: selectedExpenseQuality,
          expPay: pay,
          expAddInformation: addInformationTextController!.text,
          expUid: expenseId)
        ..whenComplete(
          () => AppSnackbar.snackarStyle(
            title: expenseDescription,
            message: 'Despesa atualizada com sucesso',
          ),
        );
      clearEditingControllers();
      Get.back();
    }
  }

  /* Função que retorna apenas as categorias do tipo despesa para preenchimento
   do DropdownbuttonFormField -------------------------------------------------*/
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
    descriptionTextController!.clear();
    selectedCategory = firstElementDrop;
    expenseValueTextFormFieldController =
        MoneyMaskedTextController(leftSymbol: 'R\$ ');
    addInformationTextController!.clear();
    selectedExpenseQuality = 'Essencial';
  }
}
