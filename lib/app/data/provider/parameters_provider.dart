import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/parameters_model.dart';

final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');

class ParametersProvider {
  //Retorna os parâmetros cadastrados
  Stream<List<ParametersModel>> getAllParameters({required String userUid}) {
    return _firebaseFirestore.doc(userUid).collection('parameter').snapshots().map(
      (query) {
        List<ParametersModel> retParameters = [];
        query.docs.forEach(
          (element) {
            retParameters.add(ParametersModel.fromDocument(element));
          },
        );
        return retParameters;
      },
    );
  }

  Future<void> verifyParameterInBD({required String userUid}) async {
    try {
      _firebaseFirestore.doc(userUid).collection('parameter').get().then((value) {
        if (value.docs.isEmpty) {
          addParameter(userUid: userUid);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // Quando usuário se registra a função adiciona valores padrões aos seus parâmetros
  Future<void> addParameter({
    required String userUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('parameter').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'parDate': DateTime.now(),
      'parDayInitialPeriod': 1,
      'parSalary': 0,
      'parWorkedHours': 0,
    };
    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza os parâmetros do usuário
  Future<void> updateParameter({
    required String userUid,
    required DateTime parDate,
    required int parDayInitialPeriod,
    required double parSalary,
    required int parWorkedHours,
    required String parUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('parameter').doc(parUid);

    Map<String, dynamic> data = <String, dynamic>{
      'parDate': parDate,
      'parDayInitialPeriod': parDayInitialPeriod,
      'parSalary': parSalary,
      'parWorkedHours': parWorkedHours,
    };
    await documentReference.update(data).catchError((e) => print(e));
  }
}
