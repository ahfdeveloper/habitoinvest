import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/provider/categories_provider.dart';

class CategoriesRepository {
  final CategoriesProvider _categoriesProvider = CategoriesProvider();

  // Lista todas as categorias
  Stream<List<CategoryModel>> getAllCategories({required String userUid}) {
    return _categoriesProvider.getAllCategories(userUid: userUid);
  }

  // Cadastra uma nova categoria
  Future addCategory(
      {required String userUid,
      required String catName,
      required String catType,
      required String catDescription}) async {
    return _categoriesProvider.addCategory(
      userUid: userUid,
      catName: catName,
      catType: catType,
      catDescription: catDescription,
    );
  }

  // Atualiza uma categoria
  Future updateCategory(
      {required String userUid,
      required String catName,
      required String catType,
      required String catDescription,
      required String catUid}) async {
    return _categoriesProvider.updateCategory(
      userUid: userUid,
      catName: catName,
      catType: catType,
      catDescription: catDescription,
      catUid: catUid,
    );
  }

  // Apaga uma categoria
  Future deleteCategory(
      {required String userUid,
      required String catUid,
      required String catName}) {
    return _categoriesProvider.deleteCategory(
        userUid: userUid, catUid: catUid, catName: catName);
  }
}
