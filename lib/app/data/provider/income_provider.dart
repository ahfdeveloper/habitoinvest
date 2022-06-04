import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/utils/app_functions.dart';
import '../model/income_model.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class IncomeProvider {
  //Retorna todas as receitas cadastradas no BD
  Stream<List<IncomeModel>> getAllIncome({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('income').orderBy('incDate', descending: true).snapshots().map(
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

  //Retorna todas as receitas de no período atual do usuário e se foram recebidas ou não
  Stream<List<IncomeModel>> getIncomeCurrent({
    required String userUid,
    required int dayInitial,
    required bool received,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('income')
        .where('incReceived', isEqualTo: received)
        .orderBy('incDate')
        .where(
          'incDate',
          isGreaterThanOrEqualTo: getInitialDateQuery(dayInitialPeriod: dayInitial).first,
          isLessThan: getInitialDateQuery(dayInitialPeriod: dayInitial).last,
        )
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

  //Retorna todas as receitas de acordo com uma categoria e período escolhidos pelo usuário
  Stream<List<IncomeModel>> getIncomePeriodWithCategory({
    required String userUid,
    required String category,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('income')
        .where('incCategory', isEqualTo: category)
        .orderBy('incDate')
        .where('incDate', isGreaterThanOrEqualTo: initialDate, isLessThanOrEqualTo: endDate)
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

  //Retorna todas as receitas, independente da categoria, de acordo com um período escolhido pelo usuário
  Stream<List<IncomeModel>> getAllIncomePeriod({
    required String userUid,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('income')
        .orderBy('incDate')
        .where('incDate', isGreaterThanOrEqualTo: initialDate, isLessThanOrEqualTo: endDate)
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

  // Atualiza uma receita editada pelo usuário
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
