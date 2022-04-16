import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../routes/routes.dart';
import 'categorieslist_controller.dart';

class CategoriesList extends GetView<CategoriesListController> {
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
          title: controller.searchBoolean == false
              ? Text('Categorias')
              : TextFormField(
                  controller: controller.searchFormFieldController,
                  style: AppTextStyles.appBarTextLight,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Descrição da categoria',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: (value) => controller.runFilter(value),
                ),
          actions: [
            // Determina qual botão vai aparece no appBar de acordo com a ação do usuário
            controller.searchBoolean == false
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => controller.searchBoolean = true,
                  )
                : IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      controller.searchBoolean = false;
                      controller.categoriesList = controller.result;
                      controller.searchFormFieldController.clear();
                    },
                  ),
          ],
        ),
        body: controller.categoriesList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(2.0),
                itemCount: controller.categoriesList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionExtentRatio: 0.25,
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      child: ListTile(
                        title: Text(controller.categoriesList[index].name!),
                        subtitle: Text(controller.categoriesList[index].description!),
                        onTap: () {
                          Get.toNamed(Routes.CATEGORIES_ADDUPDATE, arguments: {
                            'user': controller.user,
                            'addEditFlag': 'UPDATE',
                            'categoryId': controller.categoriesList[index].id!,
                            'nameTextController': TextEditingController(text: controller.categoriesList[index].name!),
                            'categoryType': controller.categoriesList[index].type!,
                            'descriptionTextController': TextEditingController(text: controller.categoriesList[index].description!),
                          });
                        },
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Apagar',
                        color: AppColors.expenseColor,
                        icon: Icons.delete,
                        onTap: () {
                          controller.categoryId = controller.categoriesList[index].id!;
                          controller.categoryName = controller.categoriesList[index].name!;
                          if (!controller.verifyCategoryIncome()) {
                            if (!controller.verifyCategoryExpense()) {
                              controller.deleteCategory();
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
            Get.toNamed(Routes.CATEGORIES_ADDUPDATE, arguments: {
              'user': controller.user,
              'addEditFlag': 'NEW',
            });
          },
          backgroundColor: AppColors.themeColor,
          tooltip: 'Nova Categoria',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
