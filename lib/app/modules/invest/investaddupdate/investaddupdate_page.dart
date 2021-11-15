import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/modules/invest/investaddupdate/investaddupdate_controller.dart';

class InvestAddUpdatePage extends StatelessWidget {
  final InvestAddUpdateController _controller = InvestAddUpdateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.investcolor,
        title: Text('Cadastrar Investimento', style: TextStyle(fontSize: 17.0)),
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.cancel, color: AppColors.white),
          ),
          IconButton(
            onPressed: () {/*Código para salvar*/},
            icon: Icon(Icons.save, color: AppColors.white),
          ),
        ],
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 13.0),
          children: [
            SizedBox(height: SPACEFORMS),
            TextFormField(
              controller: _controller.dateTextFormFieldController,
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                //fieldIcon: Icon(null),
                label: 'Data',
                hint: null,
              ),
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _controller.selectDate(context),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                //fieldIcon: Icon(null),
                label: 'valor',
                hint: null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldForms(
                //fieldIcon: Icon(null),
                label: 'Observações',
                hint: null,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
