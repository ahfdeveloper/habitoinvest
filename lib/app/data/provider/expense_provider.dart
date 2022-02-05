import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';
import 'package:habito_invest_app/app/global/functions/functions.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class ExpenseProvider {
  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('expense').orderBy('expDate').snapshots().map(
      (query) {
        List<ExpenseModel> retExpense = [];
        query.docs.forEach(
          (element) {
            retExpense.add(ExpenseModel.fromDocument(element));
          },
        );
        return retExpense;
      },
    );
  }

  //Retorna todos os gastos não essenciais pagos no período atual
  Stream<List<ExpenseModel>> getNotEssencExpCurrent({required String userUid, required int dayInitial}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .where('expQuality', isEqualTo: 'Não essencial')
        .where('expPay', isEqualTo: true)
        .orderBy('expDate')
        .where('expDate', isGreaterThanOrEqualTo: getInitialDateQuery(dayInitial).first, isLessThan: getInitialDateQuery(dayInitial).last)
        .snapshots()
        .map(
      (query) {
        List<ExpenseModel> retExpense = [];
        query.docs.forEach(
          (element) {
            retExpense.add(ExpenseModel.fromDocument(element));
          },
        );
        return retExpense;
      },
    );
  }

  // Cadastra uma nova despesa
  Future<void> addExpense(
      {required String userUid,
      required double expValue,
      required DateTime expDate,
      required String expDescription,
      required String expCategory,
      required String expQuality,
      required bool expPay,
      required String expAddInformation}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('expense').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'expValue': expValue,
      'expDate': expDate,
      'expDescription': expDescription,
      'expCategory': expCategory,
      'expQuality': expQuality,
      'expPay': expPay,
      'expAddInformation': expAddInformation,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza uma despesa editada
  Future updateExpense(
      {required String userUid,
      required double expValue,
      required DateTime expDate,
      required String expDescription,
      required String expCategory,
      required String expQuality,
      required bool expPay,
      required String expAddInformation,
      required String expUid}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('expense').doc(expUid);

    Map<String, dynamic> data = <String, dynamic>{
      'expValue': expValue,
      'expDate': expDate,
      'expDescription': expDescription,
      'expCategory': expCategory,
      'expQuality': expQuality,
      'expPay': expPay,
      'expAddInformation': expAddInformation,
    };
    await documentReference.update(data).catchError((e) => print(e));
  }

  // Deleta uma despesa
  Future deleteExpense({required String userUid, required expUid, required expDescription}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('expense').doc(expUid);
    await documentReference.delete().catchError((e) => print(e));
  }
}
