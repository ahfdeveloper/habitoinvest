import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/expense_repository.dart';

class ExpenseListController extends GetxController {
  final UserModel? user = Get.arguments;
  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ExpenseRepository _expenseRepository = ExpenseRepository();

  // String _incomeId = '';
  // String get incomeId => this._incomeId;
  // set incomeId(String value) => this._incomeId = value;

  // String _incomeName = '';
  // String get incomeName => this._incomeName;
  // set incomeName(String value) => this._incomeName = value;

  Rx<List<ExpenseModel>> _expenseList = Rx<List<ExpenseModel>>([]);
  List<ExpenseModel> get expense => _expenseList.value;

  @override
  void onInit() {
    _expenseList
        .bindStream(_expenseRepository.getAllExpense(userUid: user!.id));
    super.onInit();
  }
}
