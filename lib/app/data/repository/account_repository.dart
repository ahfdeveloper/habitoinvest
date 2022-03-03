import 'package:habito_invest_app/app/data/model/account_model.dart';
import 'package:habito_invest_app/app/data/provider/account_provider.dart';

class AccountRepository {
  final AccountProvider _accountProvider = AccountProvider();

  Stream<List<AccountModel>> getAccount({required String userUid}) {
    return _accountProvider.getAccount(userUid: userUid);
  }

  Future<void> verifyAccountInBD({required String userUid}) async {
    return _accountProvider.verifyAccountInBD(userUid: userUid);
  }

  Future<void> addAccount({
    required String userUid,
  }) async {
    return _accountProvider.addAccount(userUid: userUid);
  }

  Future<void> updateAccount(
      {required String userUid,
      required double accBalance,
      required double accValueLT,
      required String accTypeLT,
      required DateTime accDateLT,
      required String accUid}) async {
    return _accountProvider.updateAccount(
      userUid: userUid,
      accBalance: accBalance,
      accValueLT: accValueLT,
      accTypeLT: accTypeLT,
      accDateLT: accDateLT,
      accUid: accUid,
    );
  }
}
