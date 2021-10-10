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
        .snapshots()
        .map((QuerySnapshot query) {
      List<CategoryModel> retCategorie = [];
      query.docs.forEach((element) {
        retCategorie.add(CategoryModel.fromDocument(element));
      });
      return retCategorie;
    });
  }

  // Forma alternativa para leitura dos itens, para usar no StreamBuilder
  Stream<QuerySnapshot> readAllCategories({required String userUid}) {
    CollectionReference categoriesItemCollection =
        _firebaseFirestore.doc(userUid).collection('category');
    return categoriesItemCollection.snapshots();
  }

  // Cadastra uma nova categoria
  Future<void> addCategory(
      {required String userUid,
      required String catName,
      required String catDescription}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('category').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'catName': catName,
      'catDescription': catDescription
    };

    await documentReference
        .set(data)
        .whenComplete(() => print('Categoria adicionada com sucesso'))
        .catchError((e) => print(e));
  }

  readCategory({required String catId, required String userUid}) async {
    try {
      var categoriesItemCollection = await _firebaseFirestore
          .doc(userUid)
          .collection('category')
          .doc(catId)
          .get();
      if (categoriesItemCollection.exists) {
        Map<String, dynamic>? data = categoriesItemCollection.data();
        print(data);
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Atualiza uma categoria editada categoria
  // Future updateCategory(String userUid, String catName, String catDescription,
  //     String catUid) async {
  //   try {
  //     await _firebaseFirestore
  //         .doc(userUid)
  //         .collection('category')
  //         .doc(catUid)
  //         .update({'catName': catName, 'catDescription': catDescription});
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Atualiza uma categoria editada categoria
  Future updateCategory(
      {required String userUid,
      required String catName,
      required String catDescription,
      required String catUid}) async {
    DocumentReference documentReference =
        _firebaseFirestore.doc(userUid).collection('category').doc(catUid);

    Map<String, dynamic> data = <String, dynamic>{
      'catName': catName,
      'catDescription': catDescription
    };

    await documentReference
        .update(data)
        .whenComplete(() => print('Categoria atualizada com sucesso'))
        .catchError((e) => print(e));
  }
}
