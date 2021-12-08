import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/category_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar.dart';
import 'package:intl/intl.dart';

class IncomeAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CategoryRepository _categoriesRepository = CategoryRepository();
  final IncomeRepository _incomeRepository = IncomeRepository();

  // Máscara para digitação do valor da receita ------------------------------------
  MoneyMaskedTextController incomeValueTextFormFieldController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');

  /* Conjunto de variáveis necessárias para a implementação do DropdownButtonFormField
   de seleção da categoria de receita */
  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categories => _categoriesList.value;
  String firstElementDrop = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  TextEditingController dateTextController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  TextEditingController? descriptionTextController;
  TextEditingController? valueTextController;
  TextEditingController? addInformationTextController;

  // Variável usada para definição se receita foi recebida ou não
  RxBool _received = false.obs;
  bool get received => this._received.value;
  set received(bool value) => this._received.value = value;

  // Variável que guarda a descrição da receita para exibição na snackbar
  String _incomeDescription = '';
  String get incomeDescription => this._incomeDescription;
  set incomeDescription(String value) => this._incomeDescription = value;

  // Guarda e recupera o Id da receita
  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  // Variável informativa que mostra dado a serr digitado no TextFormField
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

  String _addEditFlag = '';
  String get addEditFlag => this._addEditFlag;
  set addEditFlag(String value) => this._addEditFlag = value;

  DateTime _newSelectedDate = DateTime.now();
  DateTime get newSelectedDate => this._newSelectedDate;
  set newSelectedDate(DateTime value) => this._newSelectedDate = value;

  @override
  void onInit() {
    _categoriesList.bindStream(
      _categoriesRepository.getAllCategories(userUid: user!.id),
    );
    descriptionTextController = TextEditingController();
    valueTextController = TextEditingController();
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
        TextPosition(
            offset: dateTextController.text.length,
            affinity: TextAffinity.upstream),
      );
  }

  /* Função que retorna apenas as categorias do tipo receita para preenchimento
   do DropdownbuttonFormField */
  List<String> selectIncomeCategory() {
    List<String> listCategoryIncome = [firstElementDrop];
    categories.forEach((item) {
      if (item.type == 'Receita') {
        listCategoryIncome.add(item.name!);
      }
    });
    return listCategoryIncome;
  }

  // Efetua o salvamento de uma nova receita ou de uma receita editada
  void saveUpdateIncome({required String addEditFlag}) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (descriptionTextController!.text != '' &&
          selectedCategory != selectIncomeCategory().first &&
          valueTextController!.text != '' &&
          addInformationTextController!.text != '') {
        incomeDescription = descriptionTextController!.text;
        _incomeRepository
            .addIncome(
              userUid: user!.id,
              incDate: newSelectedDate,
              incName: descriptionTextController!.text,
              incCategory: selectedCategory,
              incValue: double.parse(valueTextController!.text),
              incObservation: addInformationTextController!.text,
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
    } else if (addEditFlag == 'UPDATE') {
      if (descriptionTextController!.text != '' &&
          selectedCategory != selectIncomeCategory().first &&
          valueTextController!.text != '' &&
          addInformationTextController!.text != '') {
        incomeDescription = descriptionTextController!.text;
        _incomeRepository.updateIncome(
            userUid: user!.id,
            incDate: newSelectedDate,
            incName: descriptionTextController!.text,
            incCategory: selectedCategory,
            incValue: double.parse(valueTextController!.text),
            incObservation: addInformationTextController!.text,
            incUid: incomeId)
          ..whenComplete(
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
    descriptionTextController!.clear();
    selectedCategory = firstElementDrop;
    valueTextController!.clear();
    addInformationTextController!.clear();
  }

  // Cancela o cadastro ou edição de uma nova receita
  void cancel() {
    clearEditingControllers();
    Get.back();
  }
}
