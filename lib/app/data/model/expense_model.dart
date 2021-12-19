import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String? id;
  double? value;
  DateTime date = DateTime.now();
  String? description;
  String? category;
  String? quality;
  bool? pay;
  String? addInformation;

  ExpenseModel(
    this.id,
    this.value,
    this.date,
    this.description,
    this.category,
    this.quality,
    this.pay,
    this.addInformation,
  );

  ExpenseModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    value = double.parse(doc['expValue'].toString());
    date = (doc['expDate'] as Timestamp).toDate();
    description = doc['expDescription'];
    category = doc['expCategory'];
    quality = doc['expQuality'];
    pay = doc['expPay'];
    addInformation = doc['expAddInformation'];
  }
}
