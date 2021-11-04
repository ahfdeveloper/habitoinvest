import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/app_text_styles.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';

class CategoriesList extends StatelessWidget {
  final CategoriesListController _categoriesListController =
      Get.find<CategoriesListController>();

  final CategoriesAddUpdateController _categoriesAddUpdateController =
      Get.put(CategoriesAddUpdateController());

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
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(2.0),
          itemCount: _categoriesListController.categories.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionExtentRatio: 0.25,
              actionPane: SlidableDrawerActionPane(),
              child: Card(
                child: ListTile(
                  title:
                      Text(_categoriesListController.categories[index].name!),
                  subtitle: Text(
                      _categoriesListController.categories[index].description!),
                  onTap: () {
                    _categoriesAddUpdateController.addEditFlag = 'UPDATE';
                    _categoriesAddUpdateController.categoryId =
                        _categoriesListController.categories[index].id!;
                    _categoriesAddUpdateController.nameTextController?.text =
                        _categoriesListController.categories[index].name!;
                    _categoriesAddUpdateController.categoryType =
                        _categoriesListController.categories[index].type!;
                    _categoriesAddUpdateController
                            .descriptionTextController?.text =
                        _categoriesListController
                            .categories[index].description!;
                    _categoriesAddUpdateController.paintContainerType();
                    Get.toNamed(Routes.CATEGORIES_ADDUPDATE,
                        arguments: _categoriesListController.user);
                  },
                ),
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Apagar',
                  color: AppColors.expenseColor,
                  icon: Icons.delete,
                  onTap: () {
                    _categoriesListController.categoryId =
                        _categoriesListController.categories[index].id!;
                    _categoriesListController.categoryName =
                        _categoriesListController.categories[index].name!;
                    _categoriesListController.deleteCategory();
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _categoriesAddUpdateController.addEditFlag = 'NEW';
          _categoriesAddUpdateController.categoryType = '';
          _categoriesAddUpdateController.paintContainerType();
          Get.toNamed(Routes.CATEGORIES_ADDUPDATE,
              arguments: _categoriesListController.user);
        },
        backgroundColor: AppColors.themeColor,
        tooltip: 'Nova Categoria',
        child: Icon(Icons.add),
      ),
    );
  }
}
