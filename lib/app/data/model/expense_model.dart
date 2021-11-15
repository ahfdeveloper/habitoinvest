import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String? id;
  DateTime dateShop = DateTime.now();
  String? description;
  String? category;
  String? quality;
  String? portionNumber;
  double? portionValue;
  double? totalValue;
  DateTime? datepay;
  bool? pay;
  String? observation;

  ExpenseModel(
    this.id,
    this.dateShop,
    this.description,
    this.category,
    this.quality,
    this.portionNumber,
    this.portionValue,
    this.totalValue,
    this.datepay,
    this.pay,
    this.observation,
  );

  ExpenseModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    dateShop = (doc['expDateShop'] as Timestamp).toDate();
    description = doc['expDescription'];
    category = doc['expCategory'];
    quality = doc['expQuality'];
    portionNumber = doc['expPortionNumber'];
    portionValue = double.parse(doc['expPortionValue'].toString());
    totalValue = double.parse(doc['expTotalValue'].toString());
    datepay = (doc['expDatepay'] as Timestamp).toDate();
    pay = doc['expPay'];
    observation = doc['expObservation'];
  }
}
