import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/investment_repository.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_snackbar/app_snackbar.dart';
import 'package:habito_invest_app/app/global/widgets/constants/constants.dart';
import 'package:intl/intl.dart';

class InvestmentAddUpdateController extends GetxController {
  final UserModel? user = Get.arguments;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final InvestmentRepository _investmentRepository = InvestmentRepository();
  final AccountRepository _accountRepository = AccountRepository();

  // Controller do campo data do investimento. Por default seta a data do dia
  TextEditingController dateTextController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  // Máscara para digitação do valor da receita
  MoneyMaskedTextController investmentValueTextFormController = moneyValueController;

  // Definição do controller do restante dos campos
  TextEditingController? descriptionTextController;
  TextEditingController? addInformationTextController;

  // Lista que guarda os dados da conta do usuário
  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => _accountList.value;

  // Flag para identificar se se trata de adição ou alteração de um investimento
  String _addEditFlag = '';
  String get addEditFlag => this._addEditFlag;
  set addEditFlag(String value) => this._addEditFlag = value;

  // Guarda e recupera o Id do investimento
  String _investmentId = '';
  String get investmentId => this._investmentId;
  set investmentId(String value) => this._investmentId = value;

  // Variável que guarda valor do investimento que está em edição para atualizar o saldo da conta
  double _investimentValue = 0.0;
  double get investimentValue => this._investimentValue;
  set investimentValue(double value) => this._investimentValue = value;

  // Variável que guarda e recupera a descrição do investimento para exibição na snackbar
  String _investmentDescription = '';
  String get investmentDescription => this._investmentDescription;
  set investmentDescription(String value) => this._investmentDescription = value;

  // Variável informativa que mostra dado a ser digitado no TextFormField de descrição
  RxString _descriptionValue = 'Descrição'.obs;
  String get descriptionValue => this._descriptionValue.value;
  set descriptionValue(String value) => this._descriptionValue.value = value;

  // Variável que recebe do BD se um investimento foi efetivado ou não quando colocado em edição
  RxBool _effective = false.obs;
  bool get effective => this._effective.value;
  set effective(bool value) => this._effective.value = value;

  // Variável guarda marcação do usuário sobre efetivação do investimento e atualiza o BD
  RxBool _updateEffective = false.obs;
  bool get updateEffective => this._updateEffective.value;
  set updateEffective(bool value) => this._updateEffective.value = value;

  // Variável que carrega data de transação padrão e guarda a escolhida pelo usuário
  DateTime _newSelectedDate = DateTime.now();
  DateTime get newSelectedDate => this._newSelectedDate;
  set newSelectedDate(DateTime value) => this._newSelectedDate = value;

  @override
  void onInit() {
    descriptionTextController = TextEditingController();
    addInformationTextController = TextEditingController();
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    super.onInit();
  }

  // Pega data selecionada no Date Picker e seta textformfield
  selectDate(BuildContext context) async {
    newSelectedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.from(
            colorScheme: ColorScheme.light(
              primary: AppColors.investcolor,
              onPrimary: AppColors.themeColor,
            ),
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
          affinity: TextAffinity.upstream,
        ),
      );
  }

  // Efetua o salvamento de um novo investimento ou alteração de um já existente
  Future<void> saveUpdateInvestment({required String addEditFlag}) async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    formkey.currentState!.save();

    if (addEditFlag == 'NEW') {
      if (descriptionTextController!.text != '') {
        investmentDescription = descriptionTextController!.text;
        if (updateEffective == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! - investmentValueTextFormController.numberValue,
            accValueLT: investmentValueTextFormController.numberValue,
            accTypeLT: 'Investiment',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        }
        _investmentRepository
            .addInvestment(
                userUid: user!.id,
                invValue: investmentValueTextFormController.numberValue,
                invMadeEffective: updateEffective,
                invDate: newSelectedDate,
                invDescription: descriptionTextController!.text,
                invAddInformation: addInformationTextController!.text)
            .whenComplete(
              () => AppSnackbar.snackarStyle(
                title: investmentDescription,
                message: 'Investimento cadastrado com sucesso',
              ),
            );
        clearEditingControllers();
        Get.back();
      }
    } else if (addEditFlag == 'UPDATE') {
      if (descriptionTextController!.text != '') {
        investmentDescription = descriptionTextController!.text;
        /* Sequencia de if que define quando o saldo da conta deve ser atualizado dependendo se o investimento foi 
        marcado como efetivado ou não ---------------------------------------------------------------------------*/
        if (effective == false && updateEffective == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! - investmentValueTextFormController.numberValue,
            accValueLT: investmentValueTextFormController.numberValue,
            accTypeLT: 'Update Investiment',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        } else if (effective == true && updateEffective == false) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! + investimentValue,
            accValueLT: investmentValueTextFormController.numberValue,
            accTypeLT: 'Update Investiment',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        } else if (effective == true && updateEffective == true) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance! + investimentValue - investmentValueTextFormController.numberValue,
            accValueLT: investmentValueTextFormController.numberValue,
            accTypeLT: 'Update Investiment',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        } else if (effective == false && updateEffective == false) {
          _accountRepository.updateAccount(
            userUid: user!.id,
            accBalance: _accountList.value.first.balance!,
            accValueLT: investmentValueTextFormController.numberValue,
            accTypeLT: 'Update Investiment',
            accDateLT: newSelectedDate,
            accUid: _accountList.value.first.id!,
          );
        }

        _investmentRepository.updateInvestment(
            userUid: user!.id,
            invValue: investmentValueTextFormController.numberValue,
            invMadeEffective: updateEffective,
            invDate: newSelectedDate,
            invDescription: descriptionTextController!.text,
            invAddInformation: addInformationTextController!.text,
            invUid: investmentId)
          ..whenComplete(
            () => AppSnackbar.snackarStyle(
              title: investmentDescription,
              message: 'Investimento atualizado com sucesso',
            ),
          );
        clearEditingControllers();
        Get.back();
      }
    }
  }

  // Limpa os campos do formulário
  void clearEditingControllers() {
    moneyValueController.updateValue(0.0);
    descriptionTextController!.clear();
    addInformationTextController!.clear();
  }

  // Cancela o cadastro ou edição de uma nova receita
  void cancel() {
    clearEditingControllers();
    Get.back();
  }
}
