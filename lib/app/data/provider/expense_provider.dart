import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';

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
  Stream<List<ExpenseModel>> getNotEssencExpCurrent({required String userUid}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .where('expQuality', isEqualTo: 'Não essencial')
        .where('expPay', isEqualTo: true)
        .orderBy('expDate')
        .where('expDate', isGreaterThanOrEqualTo: getInitialDateQuery())
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

  // //Retorna todos os gastos pagos no período atual
  // Stream<List<ExpenseModel>> getExpenseCurrent({required String userUid}) {
  //   return _firebaseFirestore
  //       .doc(userUid)
  //       .collection('expense')
  //       .where('expPay', isEqualTo: true)
  //       .orderBy('expDate')
  //       .where('expDate', isGreaterThanOrEqualTo: getInitialDateQuery())
  //       .snapshots()
  //       .map(
  //     (query) {
  //       List<ExpenseModel> retExpense = [];
  //       query.docs.forEach(
  //         (element) {
  //           retExpense.add(ExpenseModel.fromDocument(element));
  //         },
  //       );
  //       return retExpense;
  //     },
  //   );
  // }

  getInitialDateQuery() {
    //DateTime date = DateTime.now();
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;

    if (day >= 20) {
      return DateTime(20, month, year, 00, 00, 00);
    } else {
      return DateTime(20, month - 1, year, year, 00, 00, 00);
    }
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
