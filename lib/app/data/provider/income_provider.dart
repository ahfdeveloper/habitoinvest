import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/income_model.dart';

final CollectionReference _firebaseFirestore =
    FirebaseFirestore.instance.collection('users');

class IncomeProvider {
  //Retorna todas as receitas cadastradas
  Stream<List<IncomeModel>> getAllIncome({required String userUid}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('income')
        .orderBy('incDate')
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
      required DateTime incDate,
      required String incName,
      required String incCategory,
      required double incValue,
      required String incObservation}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('income').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'incName': incName,
      'incDate': incDate,
      'incCategory': incCategory,
      'incValue': incValue,
      'incObservation': incObservation,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza uma receita editada
  Future updateIncome(
      {required String userUid,
      required DateTime incDate,
      required String incName,
      required String incCategory,
      required double incValue,
      required String incObservation,
      required String incUid}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('income').doc(incUid);

    Map<String, dynamic> data = <String, dynamic>{
      'incDate': incDate,
      'incName': incName,
      'incCategory': incCategory,
      'incValue': incValue,
      'incObservation': incObservation
    };

    await documentReference.update(data).catchError((e) => print(e));
  }
}
