import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/expense_model.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class ExpenseProvider {
  // Retorna todas as despesas cadastradas no BD
  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('expense').orderBy('expDate', descending: true).snapshots().map(
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

  //Retorna todas as despesas de acordo com uma categoria, qualidade da despesa e período escolhidos pelo usuário
  Stream<List<ExpenseModel>> getExpensePeriodWithCategQuality({
    required String userUid,
    required String category,
    required String expenseQuality,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .where('expCategory', isEqualTo: category)
        .where('expQuality', isEqualTo: expenseQuality)
        .orderBy('expDate')
        .where('expDate', isGreaterThanOrEqualTo: initialDate, isLessThanOrEqualTo: endDate)
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

  //Retorna todas as despesas de qualquer qualidade de acordo com uma categoria e período escolhidos pelo usuário
  Stream<List<ExpenseModel>> getExpensePeriodWithCategory({
    required String userUid,
    required String category,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .where('expCategory', isEqualTo: category)
        .orderBy('expDate')
        .where('expDate', isGreaterThanOrEqualTo: initialDate, isLessThanOrEqualTo: endDate)
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

  //Retorna todas as despesas de qualquer categoria de acordo com uma qualidade e período escolhidos pelo usuário
  Stream<List<ExpenseModel>> getExpensePeriodWithQuality({
    required String userUid,
    required String expenseQuality,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .where('expQuality', isEqualTo: expenseQuality)
        .orderBy('expDate')
        .where('expDate', isGreaterThanOrEqualTo: initialDate, isLessThanOrEqualTo: endDate)
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

  //Retorna todas as despesas, independente da categoria e qualidade da despesa de acordo com um período escolhido pelo usuário
  Stream<List<ExpenseModel>> getAllExpensePeriod({
    required String userUid,
    required DateTime initialDate,
    required DateTime endDate,
  }) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .orderBy('expDate')
        .where('expDate', isGreaterThanOrEqualTo: initialDate, isLessThanOrEqualTo: endDate)
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

  //Retorna todas as despesas não essenciais dos últimos 12 meses
  Stream<List<ExpenseModel>> getNotEssentialsExpenseLastYear({
    required String userUid,
  }) {
    DateTime _now = DateTime.now();
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .where('expDate', isGreaterThanOrEqualTo: DateTime(_now.year - 1, _now.month, _now.day, 0, 0))
        .where('expQuality', isEqualTo: 'Não essencial')
        .where('expPay', isEqualTo: true)
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

  // Atualiza uma despesa editada pelo usuário
  Future<void> updateExpense(
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
  Future<void> deleteExpense({required String userUid, required expUid, required expDescription}) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('expense').doc(expUid);
    await documentReference.delete().catchError((e) => print(e));
  }
}
