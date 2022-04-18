import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';

import '../core/theme/app_colors.dart';
import '../routes/routes.dart';

//Botão ADD de categoria colocado no cadastro/atualização de despesas e receitas
class AddCategoryButton extends StatelessWidget {
  final UserModel userData;

  const AddCategoryButton({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: IconButton(
          icon: Icon(Icons.add_box_outlined),
          color: AppColors.themeColor,
          onPressed: () => Get.toNamed(
            Routes.CATEGORIES_ADDUPDATE,
            arguments: {
              'user': userData,
              'addEditFlag': 'NEW',
            },
          ),
        ),
      ),
    );
  }
}
