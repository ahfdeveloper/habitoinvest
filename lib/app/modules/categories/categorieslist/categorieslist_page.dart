import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_controller.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesupdate/categoriesupdate_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class CategoriesList extends StatelessWidget {
  final CategoriesListController _categoriesListController =
      Get.find<CategoriesListController>();

  final CategoriesUpdateController _categoriesUpdateController =
      CategoriesUpdateController();

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Categorias', style: AppTextStyles.appBarTextLight),
        backgroundColor: interfaceColor,
      ),

      //USANDO STREAM BUILDER, POIS O GETX TEM APRESENTADO FALHA NESTE CASO
      // body: GetBuilder(
      //   init: CategoriesListController(),
      //   builder: (CategoriesListController categoryListController) {
      //     return ListView.builder(
      //       itemCount: categoryListController.categories.length,
      //       itemBuilder: (_, index) => Card(
      //         child: ListTile(
      //           title: Text(categoryListController.categories[index].name!),
      //           subtitle:
      //               Text(categoryListController.categories[index].description!),
      //         ),
      //       ),
      //     );
      //   },
      // ),

      // body: Obx(
      //   () => ListView.builder(
      //     itemCount: _categoriesListController.categoriesList.length,
      //     itemBuilder: (context, index) {
      //       return Card(
      //         child: ListTile(
      //           title:
      //               Text(_categoriesListController.categoriesList[index].name!),
      //           subtitle: Text(_categoriesListController
      //               .categoriesList[index].description!),
      //         ),
      //       );
      //     },
      //   ),
      // ),

      body: StreamBuilder(
        stream: _categoriesListController.categoriesSnapshotList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.length == 0) {
            return Center(child: Text('Não existem categorias cadastradas'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var doc = snapshot.data!;
              var item = doc.docs[index];

              return GestureDetector(
                child: ListTile(
                  title: Text(item['catName']),
                  subtitle: Text(item['catDescription']),
                  onTap: () {
                    _categoriesUpdateController.nameTextController.text =
                        item['catName']!;
                    _categoriesUpdateController.descriptionTextController.text =
                        item['catDescription'];
                    Get.toNamed(Routes.CATEGORIES_UPDATE,
                        arguments: _categoriesListController
                            .readCategorie(doc.docs[index].id));
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CATEGORIES_ADDUPDATE,
            arguments: _categoriesListController.user),
        backgroundColor: AppColors.themeColor,
        tooltip: 'Nova Categoria',
        child: Icon(Icons.add),
      ),
    );
  }
}
