import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/goals_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/goals_repository.dart';

class GoalsListController extends GetxController {
  final UserModel? user = Get.arguments;
  final GoalsRepository _goalsRepository = GoalsRepository();

  String _goalsId = '';
  String get goalsId => this._goalsId;
  set goalsId(String value) => this._goalsId = value;

  // Recebe/altera data do cadastro/edição das metas
  DateTime? _dateUpdate;
  get dateUpdate => this._dateUpdate;
  set dateUpdate(value) => this._dateUpdate = value;

  String _goalsPercentageInvestment = '';
  String get goalsPercentageInvestment => this._goalsPercentageInvestment;
  set goalsPercentageInvestment(String value) => this._goalsPercentageInvestment = value;

  String _goalsValueInvestment = '';
  String get goalsValueInvestment => this._goalsValueInvestment;
  set goalsValueInvestment(String value) => this._goalsValueInvestment = value;

  String _goalsPercNotEssentialExp = '';
  String get goalsPercNotEssentialExp => this._goalsPercNotEssentialExp;
  set goalsPercNotEssentialExp(String value) => this._goalsPercNotEssentialExp = value;

  String _goalsValNotEssentialExp = '';
  String get goalsValNotEssentialExp => this._goalsValNotEssentialExp;
  set goalsValNotEssentialExp(String value) => this._goalsValNotEssentialExp = value;

  Rx<List<GoalsModel>> _goalsList = Rx<List<GoalsModel>>([]);
  List<GoalsModel> get goalsList => _goalsList.value;
  set goalsList(List<GoalsModel> value) => this._goalsList.value = value;

  @override
  void onInit() {
    _goalsList.bindStream(_goalsRepository.getAllGoals(userUid: user!.id));
    super.onInit();
  }
}
