import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';

final CollectionReference _firebaseFirestore =
    FirebaseFirestore.instance.collection('users');

class CategoriesProvider {
  //Retorna todas as categorias cadastradas
  Stream<List<CategoryModel>> getAllCategories({required String userUid}) {
    return _firebaseFirestore
        .doc(userUid)
        .collection('category')
        .orderBy('catName')
        .snapshots()
        .map((query) {
      List<CategoryModel> retCategorie = [];
      query.docs.forEach((element) {
        retCategorie.add(CategoryModel.fromDocument(element));
      });
      return retCategorie;
    });
  }

  // Cadastra uma nova categoria
  Future<void> addCategory(
      {required String userUid,
      required String catName,
      required String catType,
      required String catDescription}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('category').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'catName': catName,
      'catType': catType,
      'catDescription': catDescription,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Atualiza uma categoria editada
  Future updateCategory(
      {required String userUid,
      required String catName,
      required String catType,
      required String catDescription,
      required String catUid}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('category').doc(catUid);

    Map<String, dynamic> data = <String, dynamic>{
      'catName': catName,
      'catType': catType,
      'catDescription': catDescription
    };

    await documentReference.update(data).catchError((e) => print(e));
  }

  // Deleta uma categoria
  Future deleteCategory(
      {required String userUid, required catUid, required catName}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('category').doc(catUid);

    await documentReference.delete().catchError((e) => print(e));
  }
}
