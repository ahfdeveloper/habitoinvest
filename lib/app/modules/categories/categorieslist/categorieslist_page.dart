import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_controller.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import '../../../widgets/app_colors.dart';
import '../../../widgets/app_text_styles.dart';

class CategoriesList extends StatelessWidget {
  final CategoriesListController _categoriesListController = Get.find<CategoriesListController>();

  final CategoriesAddUpdateController _categoriesAddUpdateController = Get.put(CategoriesAddUpdateController());

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: interfaceColor,
          automaticallyImplyLeading: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Get.back()),
          title: _categoriesListController.searchBoolean == false
              ? Text('Categorias')
              : TextFormField(
                  controller: _categoriesListController.searchFormFieldController,
                  style: AppTextStyles.appBarTextLight,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Descrição da categoria',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => _categoriesListController.runFilter(value),
                ),
          actions: [
            // Determina qual botão vai aparece no appBar de acordo com a ação do usuário
            _categoriesListController.searchBoolean == false
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _categoriesListController.searchBoolean = true,
                  )
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _categoriesListController.searchBoolean = false;
                      _categoriesListController.categoriesList = _categoriesListController.result;
                    },
                  ),
          ],
        ),
        body: _categoriesListController.categoriesList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: _categoriesListController.categoriesList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTile(
                        title: Text(_categoriesListController.categoriesList[index].name!),
                        subtitle: Text(_categoriesListController.categoriesList[index].description!),
                        onTap: () {
                          _categoriesAddUpdateController.addEditFlag = 'UPDATE';
                          _categoriesAddUpdateController.categoryId = _categoriesListController.categoriesList[index].id!;
                          _categoriesAddUpdateController.nameTextController?.text = _categoriesListController.categoriesList[index].name!;
                          _categoriesAddUpdateController.categoryType = _categoriesListController.categoriesList[index].type!;
                          _categoriesAddUpdateController.descriptionTextController?.text = _categoriesListController.categoriesList[index].description!;
                          _categoriesAddUpdateController.paintContainerType();
                          Get.toNamed(Routes.CATEGORIES_ADDUPDATE, arguments: _categoriesListController.user);
                        },
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Apagar',
                        color: AppColors.expenseColor,
                        icon: Icons.delete,
                        onTap: () {
                          _categoriesListController.categoryId = _categoriesListController.categoriesList[index].id!;
                          _categoriesListController.categoryName = _categoriesListController.categoriesList[index].name!;
                          if (!_categoriesListController.verifyCategoryIncome()) {
                            if (!_categoriesListController.verifyCategoryExpense()) {
                              _categoriesListController.deleteCategory();
                            }
                          }
                        },
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  'Não há categorias cadastradas',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.CATEGORIES_ADDUPDATE, arguments: _categoriesListController.user);
          },
          backgroundColor: AppColors.themeColor,
          tooltip: 'Nova Categoria',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
