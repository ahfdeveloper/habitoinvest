import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/goals_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';

class GoalsUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GoalsRepository _goalsRepository = GoalsRepository();
  MoneyMaskedTextController goalFixedValueController = moneyValueController;
  TextEditingController goalPercentageValueController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // Recebe a instância do controller de acordo com o formato da meta selecionada
  var controller;

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

  //--
  // Recebe/altera data do cadastro/edição das metas
  DateTime? _dateUpdate;
  get dateUpdate => this._dateUpdate;
  set dateUpdate(value) => this._dateUpdate = value;

  RxString _value = ''.obs;
  get value => this._value.value;
  set value(value) => this._value.value = value;

  //
  // Função chamada quando selecionado o botão para definir valor em porcentagem de meta
  void percentageButtonSelect() async {
    this.buttonColorPercentage = AppColors.white;
    this.buttonBackgroundColorPercentage = AppColors.themeColor;
    this.buttonColorFixedValue = AppColors.grey400;
    this.buttonBackgroundColorFixedValue = AppColors.transparent;
    this.controller = null;
    this.controller = goalPercentageValueController;
    this.controller.text = pvalue;
    this.controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)); //posiciona cursor fim do texto
  }

  // Função chamada quando selecionado o botão para definir valor fixo de meta
  void fixedValueButtonSelect() async {
    this.buttonColorFixedValue = AppColors.white;
    this.buttonBackgroundColorFixedValue = AppColors.themeColor;
    this.buttonColorPercentage = AppColors.grey400;
    this.buttonBackgroundColorPercentage = AppColors.transparent;
    this.controller = null;
    this.controller = goalFixedValueController;
    this.controller.text = fvalue;
    this.controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)); //posiciona cursor fim do texto
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

  // Cancela a atualização das metas
  void cancel() {
    controller.updateValue(0.0);
    Get.back();
  }
}
