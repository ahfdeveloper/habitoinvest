import 'package:cloud_firestore/cloud_firestore.dart';

class ParametersModel {
  String? id;
  DateTime date = DateTime.now();
  int? dayInitialPeriod;
  double? salary;
  int? workedHours;

  ParametersModel(
    this.id,
    this.date,
    this.dayInitialPeriod,
    this.salary,
    this.workedHours,
  );

  ParametersModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    date = (doc['parDate'] as Timestamp).toDate();
    dayInitialPeriod = int.parse(doc['parDayInitialPeriod'].toString());
    salary = double.parse(doc['parSalary'].toString());
    workedHours = int.parse(doc['parWorkedHours'].toString());
  }
}
