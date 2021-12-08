import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/expense_model.dart';

final CollectionReference _firebaseFirestore =
    FirebaseFirestore.instance.collection('users');

class ExpenseProvider {
  Stream<List<ExpenseModel>> getAllExpense({required String userUid}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('expense')
        .orderBy('expDatePayFirstPortion')
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
      required double expTotalValue,
      required bool expPay,
      required DateTime expDateShop,
      required String expDescription,
      required String expCategory,
      required String expQuality,
      required DateTime expDatePayFirstPortion,
      required String expPortionNumber,
      required String expTotalPortionNumber,
      required double expPortionValue,
      required String expAddInformation}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('expense').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'expTotalValue': expTotalValue,
      'expPay': expPay,
      'expDateShop': expDateShop,
      'expDescription': expDescription,
      'expCategory': expCategory,
      'expQuality': expQuality,
      'expDatePayFirstPortion': expDatePayFirstPortion,
      'expPortionNumber': expPortionNumber,
      'expTotalPortionNumber': expTotalPortionNumber,
      'expPortionValue': expPortionValue,
      'expAddInformation': expAddInformation,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }
}
