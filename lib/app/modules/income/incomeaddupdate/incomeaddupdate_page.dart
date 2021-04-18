import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/global/widgets/decoration.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';

class IncomeAddUpdatePage extends StatelessWidget{
  final IncomeAddUpdateController _controller = IncomeAddUpdateController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: INCOMECOLOR,
        title: Text('Cadastrar Receita'),
        actions: [
          IconButton(
            onPressed: () { Get.back(); },
            icon: Icon(Icons.cancel, color: TEXTCOLORLIGHT),
          ),

          IconButton(
            onPressed: () { /*Código para salvar*/ },
            icon: Icon(Icons.save, color: TEXTCOLORLIGHT),
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
              decoration: textFormFieldDecoration1('Nome', null, false)
            ),
            SizedBox(height: 5.0),

            DropdownButtonFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              items: [],
              decoration: textFormFieldDecoration1('Categoria', null, false)
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: textFormFieldDecoration1('Valor', null, false)
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