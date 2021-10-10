import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/category_model.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/repository/categories_repository.dart';

class CategoriesListController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final UserModel? user = Get.arguments;
  QueryDocumentSnapshot? category;
  RxList<CategoryModel> categoriesList = RxList<CategoryModel>([]);

  RxList<CategoryModel> get categories => categoriesList;

  @override
  void onInit() {
    // Desabilitados são trechos para listagem através do Getx
    // categoriesList
    //     .bindStream(_categoriesRepository.getAllCategories(userUid: user!.id));

    super.onInit();
  }

  // ******* PROVISÓRIO USO DE STREAMBUILDER
  categoriesSnapshotList() {
    return _categoriesRepository.readAllCategories(userUid: user!.id);
  }

  readCategorie(String catId) {
    return _categoriesRepository.readCategory(catId: catId, userUid: user!.id);
  }
}
