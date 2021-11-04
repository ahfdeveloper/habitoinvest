import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? id;
  String? name;
  String? type;
  String? description;

  CategoryModel(
    this.id,
    this.name,
    this.type,
    this.description,
  );

  CategoryModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc['catName'];
    type = doc['catType'];
    description = doc['catDescription'];
  }
}
