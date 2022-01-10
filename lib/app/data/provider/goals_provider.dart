import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/goals_model.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class GoalsProvider {
  // Retorna as metas cadastradas
  Stream<List<GoalsModel>> getAllGoals({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('goals').snapshots().map(
      (query) {
        List<GoalsModel> retGoals = [];
        query.docs.forEach(
          (element) {
            retGoals.add(GoalsModel.fromDocument(element));
          },
        );
        print(retGoals.length);
        return retGoals;
      },
    );
  }

  // Cadastra uma nova receita
  /* Future<void> addIncome(
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
  Future updateIncome(
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
  Future deleteIncome({required String userUid, required incUid, required incDescription}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('income').doc(incUid);
    await documentReference.delete().catchError((e) => print(e));
  } */
}
