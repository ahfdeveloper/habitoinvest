import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  String? id;
  DateTime date = DateTime.now();
  String? name;
  String? category;
  double? value;
  String? observation;

  IncomeModel(
    this.id,
    this.date,
    this.name,
    this.category,
    this.value,
    this.observation,
  );

  IncomeModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    date = (doc['incDate'] as Timestamp).toDate();
    name = doc['incName'];
    category = doc['incCategory'];
    value = double.parse(doc['incValue'].toString());
    observation = doc['incObservation'];
  }
}
