import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class IncomeProvider {
  //Retorna todas as receitas cadastradas
  Stream<List<IncomeModel>> getAllIncome({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('income').orderBy('incDate').snapshots().map(
      (query) {
        List<IncomeModel> retIncome = [];
        query.docs.forEach(
          (element) {
            retIncome.add(IncomeModel.fromDocument(element));
          },
        );
        return retIncome;
      },
    );
  }

  //Retorna todas as receitas recebidas no período atual
  Stream<List<IncomeModel>> getIncomeCurrent({required String userUid, required int dayInitial}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('income')
        .where('incReceived', isEqualTo: true)
        .orderBy('incDate')
        .where('incDate', isGreaterThanOrEqualTo: getInitialDateQuery(dayInitial).first, isLessThan: getInitialDateQuery(dayInitial).last)
        .snapshots()
        .map(
      (query) {
        List<IncomeModel> retIncome = [];
        query.docs.forEach(
          (element) {
            retIncome.add(IncomeModel.fromDocument(element));
          },
        );
        return retIncome;
      },
    );
  }

  // Cadastra uma nova receita
  Future<void> addIncome(
      {required String userUid,
      required double incValue,
      required bool incReceived,
      required DateTime incDate,
      required String incDescription,
      required String incCategory,
      required String incAddInformation}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('income').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'incValue': incValue,
      'incReceived': incReceived,
      'incDate': incDate,
      'incDescription': incDescription,
      'incCategory': incCategory,
      'incAddInformation': incAddInformation,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza uma receita editada
  Future<void> updateIncome(
      {required String userUid,
      required double incValue,
      required bool incReceived,
      required DateTime incDate,
      required String incDescription,
      required String incCategory,
      required String incAddInformation,
      required String incUid}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('income').doc(incUid);

    Map<String, dynamic> data = <String, dynamic>{
      'incValue': incValue,
      'incReceived': incReceived,
      'incDate': incDate,
      'incDescription': incDescription,
      'incCategory': incCategory,
      'incAddInformation': incAddInformation
    };
    await documentReference.update(data).catchError((e) => print(e));
  }

  // Deleta uma despesa
  Future<void> deleteIncome({required String userUid, required incUid, required incDescription}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('income').doc(incUid);
    await documentReference.delete().catchError((e) => print(e));
  }
}
