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
        return retGoals;
      },
    );
  }

  // Quando usuário não possui metas cadastradas adiciona valor default zero para que o mesmo atualize
  Future<void> addGoal({
    required String userUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('goals').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'gDate': DateTime.now(),
      'gPercentageInvestment': 0,
      'gPercentageNotEssentialExpenses': 0,
      'gValueInvestment': 0,
      'gValueNotEssentialExpenses': 0,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza a meta investimento
  Future updateInvestiment({
    required String userUid,
    required DateTime gDate,
    required int gPercentageInvestment,
    required double gValueInvestment,
    required String gUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('goals').doc(gUid);

    Map<String, dynamic> data = <String, dynamic>{
      'gDate': gDate,
      'gPercentageInvestment': gPercentageInvestment,
      'gValueInvestment': gValueInvestment,
    };
    await documentReference.update(data).catchError((e) => print(e));
  }

  // Atualiza a meta gastos não essenciais
  Future updateNotEssentialExpense({
    required String userUid,
    required DateTime gDate,
    required int gPercentageNotEssentialExpenses,
    required double gValueNotEssentialExpenses,
    required String gUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('goals').doc(gUid);

    Map<String, dynamic> data = <String, dynamic>{
      'gDate': gDate,
      'gPercentageNotEssentialExpenses': gPercentageNotEssentialExpenses,
      'gValueNotEssentialExpenses': gValueNotEssentialExpenses,
    };
    await documentReference.update(data).catchError((e) => print(e));
  }
}
