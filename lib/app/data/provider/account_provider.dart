import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/account_model.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class AccountProvider {
  //Retorna o registro da conta
  Stream<List<AccountModel>> getAccount({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('account').snapshots().map(
      (query) {
        List<AccountModel> retAccount = [];
        query.docs.forEach(
          (element) {
            retAccount.add(AccountModel.fromDocument(element));
          },
        );
        return retAccount;
      },
    );
  }

  // Quando usuário não possui dados de account cadastrada adiciona valor default zero para os campos
  Future<void> addAccount({
    required String userUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('account').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'accBalance': 0,
      'accValueLT': 0,
      'accTypeLT': 'Inicio',
      'accDateLT': DateTime.now(),
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  //Atualiza os dados da conta
  Future updateAccount(
      {required String userUid,
      required double accBalance,
      required double accValueLT,
      required String accTypeLT,
      required DateTime accDateLT,
      required String accUid}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('account').doc(accUid);

    Map<String, dynamic> data = <String, dynamic>{
      'accBalance': accBalance,
      'accValueLT': accValueLT,
      'accTypeLT': accTypeLT,
      'accDateLT': accDateLT,
    };
    await documentReference.update(data).catchError((e) => print(e));
  }
}
