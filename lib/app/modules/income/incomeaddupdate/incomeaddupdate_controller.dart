import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/categories_repository.dart';
import 'package:habito_invest_app/app/data/repository/income_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar.dart';
import 'package:intl/intl.dart';

class IncomeAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final IncomeRepository _incomeRepository = IncomeRepository();

  Rx<List<CategoryModel>> _categoriesList = Rx<List<CategoryModel>>([]);
  List<CategoryModel> get categories => _categoriesList.value;

  String firstElementDrop = 'Selecione uma categoria...';
  var _selectedCategory = 'Selecione uma categoria...'.obs;
  String get selectedCategory => this._selectedCategory.value;
  set selectedCategory(String select) => _selectedCategory.value = select;

  TextEditingController dateTextController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    ),
  );

  TextEditingController? nameTextController;
  TextEditingController? valueTextController;
  TextEditingController? observationTextController;

  String _incomeId = '';
  String get incomeId => this._incomeId;
  set incomeId(String value) => this._incomeId = value;

  String _incomeName = '';
  String get incomeName => this._incomeName;
  set incomeName(String value) => this._incomeName = value;

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
    nameTextController = TextEditingController();
    valueTextController = TextEditingController();
    observationTextController = TextEditingController();
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

  void saveUpdateIncome({required String addEditFlag}) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (nameTextController!.text != '' &&
          selectedCategory != selectIncomeCategory().first &&
          valueTextController!.text != '' &&
          observationTextController!.text != '') {
        incomeName = nameTextController!.text;
        _incomeRepository
            .addIncome(
              userUid: user!.id,
              incDate: newSelectedDate,
              incName: nameTextController!.text,
              incCategory: selectedCategory,
              incValue: double.parse(valueTextController!.text),
              incObservation: observationTextController!.text,
            )
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                title: incomeName,
                message: 'Receita cadastrada com sucesso',
              ),
            );
        clearEditingControllers();
        Get.back();
      }
    } else if (addEditFlag == 'UPDATE') {
      if (nameTextController!.text != '' &&
          selectedCategory != selectIncomeCategory().first &&
          valueTextController!.text != '' &&
          observationTextController!.text != '') {
        incomeName = nameTextController!.text;
        _incomeRepository.updateIncome(
            userUid: user!.id,
            incDate: newSelectedDate,
            incName: nameTextController!.text,
            incCategory: selectedCategory,
            incValue: double.parse(valueTextController!.text),
            incObservation: observationTextController!.text,
            incUid: incomeId)
          ..whenComplete(
            () => AppSnackbar.snackarStyle(
              title: incomeName,
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
    nameTextController!.clear();
    selectedCategory = firstElementDrop;
    valueTextController!.clear();
    observationTextController!.clear();
  }

  // Cancela o cadastro ou edição de uma nova categoria
  void cancel() {
    clearEditingControllers();
    Get.back();
  }
}
