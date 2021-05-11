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
      appBar: AppBar(
        backgroundColor: AppColors.investcolor,
        title: Text('Cadastrar Investimento', style: TextStyle(fontSize: 17.0)),
        iconTheme: IconThemeData(color: AppColors.black),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.cancel, color: AppColors.black),
          ),
          IconButton(
            onPressed: () {/*Código para salvar*/},
            icon: Icon(Icons.save, color: AppColors.black),
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
              decoration: textFormFieldDecoration1('Data', null, false),
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _controller.selectDate(context),
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldDecoration1('valor', null, false),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: SPACEFORMS),
            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldDecoration1('Observações', null, true),
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
