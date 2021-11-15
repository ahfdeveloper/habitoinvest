import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';

final CollectionReference _firebaseFirestore =
    FirebaseFirestore.instance.collection('users');

class ExpenseProvider {
  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .orderBy('expDatepay')
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
}
