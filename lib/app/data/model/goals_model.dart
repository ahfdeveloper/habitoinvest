import 'package:cloud_firestore/cloud_firestore.dart';

class GoalsModel {
  String? id;
  DateTime date = DateTime.now();
  double? valueNotEssentialExpenses;
  int? percentageNotEssentialExpenses;
  double? valueInvestment;
  int? percentageInvestiment;

  GoalsModel(
    this.id,
    this.date,
    this.valueNotEssentialExpenses,
    this.percentageNotEssentialExpenses,
    this.valueInvestment,
    this.percentageInvestiment,
  );

  GoalsModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    date = (doc['gDate'] as Timestamp).toDate();
    valueNotEssentialExpenses = double.parse(doc['gValueNotEssentialExpenses'].toString());
    percentageNotEssentialExpenses = int.parse(doc['gPercentageNotEssentialExpenses'].toString());
    valueInvestment = double.parse(doc['gValueInvestment'].toString());
    percentageInvestiment = int.parse(doc['gPercentageInvestment'].toString());
  }
}
