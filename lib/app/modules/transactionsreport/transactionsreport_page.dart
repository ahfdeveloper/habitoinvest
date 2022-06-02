import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global_widgets/divider_horizontal.dart';
import 'package:habito_invest_app/app/modules/transactionsreport/transactionsreport_controller.dart';
import 'package:habito_invest_app/app/routes/routes.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decoration.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';
import '../../core/values/app_constants.dart';
import '../../global_widgets/buttons.dart';

class TransactionsReportPage extends GetView<TransactionsReportController> {
  const TransactionsReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color interfaceColor = AppColors.themeColor;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => cancel()),
        backgroundColor: interfaceColor,
        title: Text('Relatórios', style: AppTextStyles.appBarTextLight),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: textFormFieldForms(fieldIcon: Icons.attach_money, hint: ''),
                style: AppTextStyles.dropdownText,
                hint: Text(''),
                value: controller.selectedTransactionType,
                items: controller.transactionTypeList.map(
                  (value) {
                    return DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          value == 'Selecione um tipo de transação...'
                              ? Icon(Icons.circle_outlined)
                              : Icon(
                                  Icons.circle,
                                  color: value == 'Despesa'
                                      ? AppColors.expenseColor
                                      : value == 'Receita'
                                          ? AppColors.incomeColor
                                          : value == 'Investimento'
                                              ? AppColors.investColor
                                              : AppColors.themeColor,
                                ),
                          Text('    '),
                          Text(value),
                        ],
                      ),
                      value: value,
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  controller.selectedTransactionType = newValue as String;
                  controller.makeDropdownCategories();
                  controller.makeDropdownQualityExpense();
                },
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: textFormFieldForms(fieldIcon: Icons.category_outlined, hint: ''),
                elevation: 16,
                style: AppTextStyles.dropdownText,
                hint: Text(''),
                value: controller.selectedCategory,
                items: controller.listCategory.map(
                  (String value) {
                    return DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          value == 'Selecione uma categoria...'
                              ? Icon(Icons.circle_outlined)
                              : Icon(Icons.circle,
                                  color: value == 'Todos'
                                      ? AppColors.themeColor
                                      : controller.selectedTransactionType == 'Receita'
                                          ? AppColors.incomeColor
                                          : AppColors.expenseColor),
                          Text('    '),
                          Text(value),
                        ],
                      ),
                      value: value,
                    );
                  },
                ).toList(),
                onChanged: controller.enableCategory == true ? (newValue) => controller.selectedCategory = newValue as String : null,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: textFormFieldForms(fieldIcon: Icons.payment_outlined, hint: ''),
                style: AppTextStyles.dropdownText,
                value: controller.selectedExpenseQuality,
                items: controller.expenseQualityList.map(
                  (value) {
                    return DropdownMenuItem<String>(
                      child: Row(
                        children: [
                          value == 'Selecione a qualidade da despesa...'
                              ? Icon(Icons.circle_outlined)
                              : Icon(Icons.circle,
                                  color: value == 'Não essencial'
                                      ? AppColors.expenseColor
                                      : value == 'Essencial'
                                          ? AppColors.incomeColor
                                          : value == 'Não essencial, mas importante'
                                              ? AppColors.investColor
                                              : AppColors.themeColor),
                          Text('    '),
                          Text(value),
                        ],
                      ),
                      value: value,
                    );
                  },
                ).toList(),
                onChanged: controller.enableQualityExpense == true ? (newValue) => controller.selectedExpenseQuality = newValue as String : null,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: controller.initialDateTextController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldFormsLeading(
                fieldIcon: Icons.date_range_outlined,
                label: 'De: ',
                hint: null,
              ),
              style: AppTextStyles.dropdownText,
              onTap: () => controller.selectInitialDate(context),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: controller.endDateTextController,
              focusNode: DisabledFocusNode(),
              decoration: textFormFieldFormsLeading(
                fieldIcon: Icons.date_range_outlined,
                label: 'Até: ',
                hint: null,
              ),
              style: AppTextStyles.dropdownText,
              onTap: () => controller.selectEndDate(context),
            ),
            DividerHorizontal(),
            SizedBox(height: SPACEFORMS),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ButtonWidget.black(
                label: 'BUSCAR',
                onTap: () => {
                  Get.toNamed(Routes.REPORTLIST, arguments: {
                    'user': controller.user,
                    'transactionType': controller.selectedTransactionType,
                    'category': controller.selectedCategory,
                    'expenseQuality': controller.selectedExpenseQuality,
                    'initialDate': controller.initialDate,
                    'endDate': controller.endDate,
                  }),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
