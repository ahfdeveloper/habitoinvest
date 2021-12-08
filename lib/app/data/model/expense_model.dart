import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String? id;
  double? totalValue;
  bool? pay;
  DateTime dateShop = DateTime.now();
  String? description;
  String? category;
  String? quality;
  DateTime? datePayFirstPortion;
  String? portionNumber;
  String? totalPortionNumber;
  double? portionValue;
  String? addInformation;

  ExpenseModel(
    this.id,
    this.totalValue,
    this.pay,
    this.dateShop,
    this.description,
    this.category,
    this.quality,
    this.datePayFirstPortion,
    this.portionNumber,
    this.totalPortionNumber,
    this.portionValue,
    this.addInformation,
  );

  ExpenseModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    totalValue = double.parse(doc['expTotalValue'].toString());
    pay = doc['expPay'];
    dateShop = (doc['expDateShop'] as Timestamp).toDate();
    description = doc['expDescription'];
    category = doc['expCategory'];
    quality = doc['expQuality'];
    datePayFirstPortion = (doc['expDatePayFirstPortion'] as Timestamp).toDate();
    portionNumber = doc['expPortionNumber'];
    totalPortionNumber = doc['expTotalPortionNumber'];
    portionValue = double.parse(doc['expPortionValue'].toString());
    addInformation = doc['expAddInformation'];
  }
}
