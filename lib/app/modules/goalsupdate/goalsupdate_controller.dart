import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_masks.dart';
import '../../data/model/user_model.dart';
import '../../data/service/goals_repository.dart';
import '../../global_widgets/app_snackbar.dart';

class GoalsUpdateController extends GetxController {
  final UserModel? user = Get.arguments['user'];
  final GoalsRepository _goalsRepository = GoalsRepository();
  MoneyMaskedTextController goalFixedValueController = moneyValueController;
  TextEditingController goalPercentageValueController = TextEditingController(text: '');
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // Recebe a instância do controller de acordo com o formato da meta selecionada
  var controller;

  int _maxLength = 0;
  int get maxLength => this._maxLength;
  set maxLength(int value) => this._maxLength = value;

  // Recebe o nome da meta que está sendo cadastrada/editada
  String _title = '';
  String get title => this._title;
  set title(String value) => this._title = value;

  // Cores dos botões Porcentagem e Valor Fixo com seus getters e setters
  Rx<Color> _buttonColorPercentage = AppColors.themeColor.obs;
  get buttonColorPercentage => this._buttonColorPercentage.value;
  set buttonColorPercentage(value) => this._buttonColorPercentage.value = value;

  Rx<Color> _buttonBackgroundColorPercentage = AppColors.transparent.obs;
  get buttonBackgroundColorPercentage => this._buttonBackgroundColorPercentage.value;
  set buttonBackgroundColorPercentage(value) => this._buttonBackgroundColorPercentage.value = value;

  Rx<Color> _buttonColorFixedValue = AppColors.themeColor.obs;
  get buttonColorFixedValue => this._buttonColorFixedValue.value;
  set buttonColorFixedValue(value) => this._buttonColorFixedValue.value = value;

  Rx<Color> _buttonBackgroundColorFixedValue = AppColors.transparent.obs;
  get buttonBackgroundColorFixedValue => this._buttonBackgroundColorFixedValue.value;
  set buttonBackgroundColorFixedValue(value) => this._buttonBackgroundColorFixedValue.value = value;

  bool _pVisible = false;
  get pVisible => this._pVisible;
  set pVisible(value) => this._pVisible = value;

  bool _fVisible = false;
  get fVisible => this._fVisible;
  set fVisible(value) => this._fVisible = value;

  // Guarda a meta definida em porcentagem para exibição na tela
  RxString _pvalue = ''.obs;
  get pvalue => this._pvalue.value;
  set pvalue(value) => this._pvalue.value = value;

  // Guarda a meta definida em valor fixo para exibição na tela
  RxString _fvalue = ''.obs;
  get fvalue => this._fvalue.value;
  set fvalue(value) => this._fvalue.value = value;

  //Guarda e recupera o Id da meta
  String _goalId = '';
  String get goalId => this._goalId;
  set goalId(String value) => this._goalId = value;

  // Recebe/altera data do cadastro/edição das metas
  DateTime? _dateUpdate;
  get dateUpdate => this._dateUpdate;
  set dateUpdate(value) => this._dateUpdate = value;

  RxString _value = ''.obs;
  get value => this._value.value;
  set value(value) => this._value.value = value;

  @override
  void onInit() {
    title = Get.arguments['title'];
    goalId = Get.arguments['goalId'];
    fvalue = Get.arguments['fvalue'];
    pvalue = Get.arguments['pvalue'];
    if (double.parse(fvalue) != 0) {
      fixedValueButtonSelect();
    } else {
      percentageButtonSelect();
    }
    super.onInit();
  }

  // Função chamada quando selecionado o botão para definir valor em porcentagem de meta
  void percentageButtonSelect() async {
    pVisible = true;
    fVisible = false;
    buttonColorPercentage = AppColors.white;
    buttonBackgroundColorPercentage = AppColors.themeColor;
    buttonColorFixedValue = AppColors.grey800;
    buttonBackgroundColorFixedValue = AppColors.transparent;
    maxLength = 2;
    controller = null;
    controller = goalPercentageValueController;
    if (pvalue != '0') {
      controller = TextEditingController(text: pvalue);
    }
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)); //posiciona cursor fim do texto
  }

  // Função chamada quando selecionado o botão para definir valor fixo de meta
  void fixedValueButtonSelect() async {
    pVisible = false;
    fVisible = true;
    buttonColorFixedValue = AppColors.white;
    buttonBackgroundColorFixedValue = AppColors.themeColor;
    buttonColorPercentage = AppColors.grey800;
    buttonBackgroundColorPercentage = AppColors.transparent;
    maxLength = 100;
    controller = null;
    controller = goalFixedValueController;
    controller.text = fvalue;
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)); //posiciona cursor fim do texto
  }

// Efetua o atualização da meta selecionada
  void updateGoal() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();
    if (title == 'Investimentos') {
      if (controller == goalPercentageValueController) {
        _goalsRepository.updateInvestiment(
          userUid: user!.id,
          gDate: DateTime.now(),
          gPercentageInvestment: int.parse(controller.text),
          gValueInvestment: 0,
          gUid: goalId,
        )..whenComplete(
            () => AppSnackbar.snackarStyle(
              title: 'Investimento',
              message: 'Meta cadastrada/atualizada com sucesso',
            ),
          );
        controller.clear();
        Get.back();
      } else {
        _goalsRepository.updateInvestiment(
          userUid: user!.id,
          gDate: DateTime.now(),
          gPercentageInvestment: 0,
          gValueInvestment: controller.numberValue,
          gUid: goalId,
        )..whenComplete(
            () => AppSnackbar.snackarStyle(
              title: 'Investimento',
              message: 'Meta cadastrada/atualizada com sucesso',
            ),
          );
        controller.updateValue(0.0);
        Get.back();
      }
    } else if (title == 'Gastos não essenciais') {
      if (controller == goalPercentageValueController) {
        _goalsRepository.updateNotEssentialExpense(
          userUid: user!.id,
          gDate: DateTime.now(),
          gPercentageNotEssentialExpenses: int.parse(controller.text),
          gValueNotEssentialExpenses: 0,
          gUid: goalId,
        )..whenComplete(
            () => AppSnackbar.snackarStyle(
              title: 'Gastos não essenciais',
              message: 'Meta cadastrada/atualizada com sucesso',
            ),
          );
        controller.clear();
        Get.back();
      } else {
        _goalsRepository.updateNotEssentialExpense(
          userUid: user!.id,
          gDate: DateTime.now(),
          gPercentageNotEssentialExpenses: 0,
          gValueNotEssentialExpenses: controller.numberValue,
          gUid: goalId,
        )..whenComplete(
            () => AppSnackbar.snackarStyle(
              title: 'Gastos não essenciais',
              message: 'Meta cadastrada/atualizada com sucesso',
            ),
          );
        controller.updateValue(0.0);
        Get.back();
      }
    }
  }
}
