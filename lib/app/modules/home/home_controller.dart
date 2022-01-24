import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/model/goals_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/account_repository.dart';
import 'package:habito_invest_app/app/data/repository/goals_repository.dart';

class HomeController extends GetxController {
  final UserModel? user = Get.arguments;
  GoalsRepository _goalsRepository = Get.put(GoalsRepository());
  AccountRepository _accountRepository = Get.put(AccountRepository());

  Rx<List<GoalsModel>> _goalsList = Rx<List<GoalsModel>>([]);
  List<GoalsModel> get goalsList => this._goalsList.value;
  set goalsList(List<GoalsModel> value) => this._goalsList.value = value;

  Rx<List<AccountModel>> _accountList = Rx<List<AccountModel>>([]);
  List<AccountModel> get accountList => this._accountList.value;
  set accountList(List<AccountModel> value) => this._accountList.value = value;

  RxString _balance = ''.obs;
  String get balance => this._balance.value;
  set balance(String value) => this._balance.value = value;

  // Setter e Getter para variável currentIndex, para que a responsabilidade pela
  // alteração dos estados fique sob responsabilidade do controller
  RxInt _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(value) => this._currentIndex.value = value;

  @override
  void onInit() {
    _goalsList.bindStream(_goalsRepository.getAllGoals(userUid: user!.id));
    _accountList.bindStream(_accountRepository.getAccount(userUid: user!.id));
    super.onInit();
  }

  void changePage(int index) async {
    currentIndex = index;
  }
}
