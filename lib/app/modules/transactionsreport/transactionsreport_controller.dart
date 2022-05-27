import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../data/model/category_model.dart';
import '../../data/model/user_model.dart';
import '../../data/service/category_repository.dart';

class TransactionsReportController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final CategoryRepository _categoriesRepository = CategoryRepository();

  // Itens constantes no DropDownFormField de tipo de transação
  final List transactionTypeList = ['Selecione um tipo de transação...', 'Receita', 'Despesa', 'Investimento'];
  String firstElementDropTransaction = 'Selecione um tipo de transação...';
  RxString _selectedTransactionType = 'Selecione um tipo de transação...'.obs;
  String get selectedTransactionType => this._selectedTransactionType.value;
  set selectedTransactionType(String value) => _selectedTransactionType.value = value;

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField de 
  seleção da categoria de despesa */
  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categories => _categoriesList.value;
  String firstElementDropCategory = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  // Itens constantes no DropDownFormField de qualidade da despesa
  RxList<String> expenseQualityList = [
    'Selecione a qualidade da despesa...',
    'Todos',
    'Essencial',
    'Não essencial, mas importante',
    'Não essencial',
  ].obs;
  String firstElementDropQuality = 'Selecione a qualidade da despesa...';
  RxString _selectedExpenseQuality = 'Selecione a qualidade da despesa...'.obs;
  String get selectedExpenseQuality => this._selectedExpenseQuality.value;
  set selectedExpenseQuality(String value) => this._selectedExpenseQuality.value = value;

  // Guarda as categorias a serem listadas no DropdownFormField de Categorias
  RxList<String> listCategory = [''].obs;

  // Flag que indica se DrodownFormField de categoria deve ser desabilitado
  bool enableCategory = true;

  // Flag que indica se DrodownFormField de qualidade de despesa deve ser desabilitado
  bool enableQualityExpense = true;

// Definição de valor inicial para o campo de data da Receita
  TextEditingController initialDateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController endDateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  // Guarda a data escolhida pelo usuário no Data Picker
  DateTime _initialDate = DateTime.now();
  DateTime get initialDate => this._initialDate;
  set initialDate(DateTime value) => this._initialDate = value;

  // Guarda a data escolhida pelo usuário no Data Picker
  DateTime _endDate = DateTime.now();
  DateTime get endDate => this._endDate;
  set endDate(DateTime value) => this._endDate = value;

  void onInit() {
    _categoriesList.bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));
    selectCategory();
    super.onInit();
  }

  // Preenche data inicial no respectivo textformFields de data da page
  selectInitialDate(BuildContext context) async {
    initialDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.from(
            colorScheme: ColorScheme.light(primary: AppColors.themeColor),
          ),
          child: child!,
        );
      },
    ))!;
    initialDateTextController
      ..text = DateFormat('dd/MM/yyyy').format(initialDate)
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: initialDateTextController.text.length, affinity: TextAffinity.upstream),
      );
  }

  // Preenche data inicial no respectivo textformFields de data da page
  selectEndDate(BuildContext context) async {
    endDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.from(
            colorScheme: ColorScheme.light(primary: AppColors.themeColor),
          ),
          child: child!,
        );
      },
    ))!;
    endDateTextController
      ..text = DateFormat('dd/MM/yyyy').format(endDate)
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: endDateTextController.text.length, affinity: TextAffinity.upstream),
      );
  }

  // Adiciona itens no Dropdown de categorias de acordo com o tipo de transação escolhido
  makeDropdownCategories() {
    if (selectedTransactionType == 'Investimento') {
      listCategory.clear();
      listCategory.add(firstElementDropCategory);
      selectedCategory = firstElementDropCategory;
      enableCategory = false;
    } else if (selectedTransactionType == 'Todos') {
      listCategory.clear();
      listCategory.add('Todos');
      selectedCategory = 'Todos';
      enableCategory = true;
    } else {
      selectCategory();
      selectedCategory = firstElementDropCategory;
      enableCategory = true;
    }
  }

  // Adiciona itens no Dropdown de categorias de acordo com o tipo de transação escolhido
  makeDropdownQualityExpense() {
    if (selectedTransactionType == 'Investimento' || selectedTransactionType == 'Receita') {
      expenseQualityList.clear();
      expenseQualityList.add(firstElementDropQuality);
      selectedExpenseQuality = firstElementDropQuality;
      enableQualityExpense = false;
    } else if (selectedTransactionType == 'Despesa') {
      expenseQualityList.clear();
      expenseQualityList.add('Selecione a qualidade da despesa...');
      expenseQualityList.add('Todos');
      expenseQualityList.add('Essencial');
      expenseQualityList.add('Não essencial, mas importante');
      expenseQualityList.add('Não essencial');
      selectedExpenseQuality = firstElementDropQuality;
      enableQualityExpense = true;
    } else if (selectedTransactionType == 'Todos') {
      expenseQualityList.clear();
      expenseQualityList.add('Todos');
      selectedExpenseQuality = 'Todos';
      enableQualityExpense = true;
    }
  }

  // Retorna as categorias cadastrada no banco em função do tipo de transação selecionada (Receita ou Despesa)
  selectCategory() {
    listCategory.clear();
    listCategory.add(firstElementDropCategory);
    listCategory.add('Todos');
    categories.forEach(
      (item) {
        if (item.type == selectedTransactionType) {
          listCategory.add(item.name!);
        }
      },
    );
  }
}
