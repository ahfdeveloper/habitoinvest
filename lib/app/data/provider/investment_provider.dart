import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/investment_model.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class InvestmentProvider {
  //Retorna todos os investimentos cadastrados
  Stream<List<InvestmentModel>> getAllInvestment({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('investment').orderBy('invDate').snapshots().map(
      (query) {
        List<InvestmentModel> retInvestment = [];
        query.docs.forEach(
          (element) {
            retInvestment.add(InvestmentModel.fromDocument(element));
          },
        );
        return retInvestment;
      },
    );
  }

  //Retorna todas os investimentos feitos no período atual
  Stream<List<InvestmentModel>> getInvestmentCurrent({required String userUid, required int dayInitial}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('investment')
        .where('invMadeEffective', isEqualTo: true)
        .orderBy('invDate')
        .where('invDate', isGreaterThanOrEqualTo: getInitialDateQuery(dayInitial).first, isLessThan: getInitialDateQuery(dayInitial).last)
        .snapshots()
        .map(
      (query) {
        List<InvestmentModel> retInvestment = [];
        query.docs.forEach(
          (element) {
            retInvestment.add(InvestmentModel.fromDocument(element));
          },
        );
        return retInvestment;
      },
    );
  }

  // Cadastra um novo investimento
  Future<void> addInvestment(
      {required String userUid,
      required double invValue,
      required bool invMadeEffective,
      required DateTime invDate,
      required String invDescription,
      required String invAddInformation}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('investment').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'invValue': invValue,
      'invMadeEffective': invMadeEffective,
      'invDate': invDate,
      'invDescription': invDescription,
      'invAddInformation': invAddInformation,
    };
    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza um investimento cadastrado
  Future<void> updateInvestment(
      {required String userUid,
      required double invValue,
      required bool invMadeEffective,
      required DateTime invDate,
      required String invDescription,
      required String invAddInformation,
      required String invUid}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('investment').doc(invUid);

    Map<String, dynamic> data = <String, dynamic>{
      'invValue': invValue,
      'invMadeEffective': invMadeEffective,
      'invDate': invDate,
      'invDescription': invDescription,
      'invAddInformation': invAddInformation
    };
    await documentReference.update(data).catchError((e) => print(e));
  }

  // Deleta um investimento
  Future<void> deleteInvestment({required String userUid, required invUid, required invDescription}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('investment').doc(invUid);
    await documentReference.delete().catchError((e) => print(e));
  }
}
