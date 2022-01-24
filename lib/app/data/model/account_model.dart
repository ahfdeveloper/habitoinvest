import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  String? id;
  double? balance;
  double? valueLastTransaction;
  String? typeLastTransaction;
  DateTime dateLastTransaction = DateTime.now();

  AccountModel(
    this.id,
    this.balance,
    this.valueLastTransaction,
    this.typeLastTransaction,
    this.dateLastTransaction,
  );

  AccountModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    balance = double.parse(doc['accBalance'].toString());
    valueLastTransaction = double.parse(doc['accValueLT'].toString());
    typeLastTransaction = doc['accTypeLT'];
    dateLastTransaction = (doc['accDateLT'] as Timestamp).toDate();
  }
}
