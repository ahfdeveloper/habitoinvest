import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/provider/categories_provider.dart';

class CategoriesRepository {
  final CategoriesProvider _categoriesProvider = CategoriesProvider();

  // Lista todas as categorias
  Stream<List<CategoryModel>> getAllCategories({required String userUid}) {
    return _categoriesProvider.getAllCategories(userUid: userUid);
  }

  // Forma alternativa para leitura dos itens, para usar StreamBuilder
  Stream<QuerySnapshot> readAllCategories({required String userUid}) {
    return _categoriesProvider.readAllCategories(userUid: userUid);
  }

  // Cadastra uma nova categoria
  Future addCategory(
      {required String userUid,
      required String catName,
      required String catDescription}) async {
    return _categoriesProvider.addCategory(
      userUid: userUid,
      catName: catName,
      catDescription: catDescription,
    );
  }

  readCategory({required String catId, required String userUid}) {
    return _categoriesProvider.readCategory(catId: catId, userUid: userUid);
  }

  // Atualiza uma categoria
  Future updateCategory(
      {required String userUid,
      required String catName,
      required String catDescription,
      required String catUid}) async {
    return _categoriesProvider.updateCategory(
      userUid: userUid,
      catName: catName,
      catDescription: catDescription,
      catUid: catUid,
    );
  }
}
