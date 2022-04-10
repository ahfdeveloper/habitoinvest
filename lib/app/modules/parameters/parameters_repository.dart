import 'package:habito_invest_app/app/data/model/parameters_model.dart';
import 'package:habito_invest_app/app/data/provider/parameters_provider.dart';

class ParametersRepository {
  final ParametersProvider _parametersProvider = ParametersProvider();

  Stream<List<ParametersModel>> getAllParameters({required String userUid}) {
    return _parametersProvider.getAllParameters(userUid: userUid);
  }

  Future<void> verifyParameterInBD({required String userUid}) async {
    return _parametersProvider.verifyParameterInBD(userUid: userUid);
  }

  Future<void> addParameter({required String userUid}) async {
    return _parametersProvider.addParameter(userUid: userUid);
  }

  Future<void> updateParameter({
    required String userUid,
    required DateTime parDate,
    required int parDayInitialPeriod,
    required double parSalary,
    required int parWorkeHours,
    required String parUid,
  }) async {
    return _parametersProvider.updateParameter(
      userUid: userUid,
      parDate: parDate,
      parDayInitialPeriod: parDayInitialPeriod,
      parSalary: parSalary,
      parWorkedHours: parWorkeHours,
      parUid: parUid,
    );
  }
}
