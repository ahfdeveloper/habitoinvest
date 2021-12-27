import 'package:cloud_firestore/cloud_firestore.dart';

class InvestmentModel {
  String? id;
  double? value;
  bool? madeEffective;
  DateTime date = DateTime.now();
  String? description;
  String? addInformation;

  InvestmentModel(
    this.id,
    this.value,
    this.madeEffective,
    this.date,
    this.description,
    this.addInformation,
  );

  InvestmentModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    value = double.parse(doc['invValue'].toString());
    madeEffective = doc['invMadeEffective'];
    date = (doc['invDate'] as Timestamp).toDate();
    description = doc['invDescription'];
    addInformation = doc['invAddInformation'];
  }
}
