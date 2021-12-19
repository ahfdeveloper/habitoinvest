import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  String? id;
  double? value;
  bool? received;
  DateTime date = DateTime.now();
  String? description;
  String? category;
  String? addInformation;

  IncomeModel(
    this.id,
    this.value,
    this.received,
    this.date,
    this.description,
    this.category,
    this.addInformation,
  );

  IncomeModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    value = double.parse(doc['incValue'].toString());
    received = doc['incReceived'];
    date = (doc['incDate'] as Timestamp).toDate();
    description = doc['incDescription'];
    category = doc['incCategory'];
    addInformation = doc['incAddInformation'];
  }
}
