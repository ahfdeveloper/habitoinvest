import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_controller.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_controller.dart';

class ExpenseAddUpdatePage extends StatelessWidget{
  final ExpenseAddUpdateController _controller = ExpenseAddUpdateController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EXPENSECOLOR,
        title: Text('Cadastrar Despesa'),
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
              decoration: InputDecoration(labelText: 'Data'),
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () => _controller.selectDate(context),
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Nome',                
              ),
            ),
            SizedBox(height: 5.0),

            DropdownButtonFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              items: [],
              decoration: InputDecoration(
                labelText: 'Categoria',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
            ),
            SizedBox(height: SPACEFORMS),

            TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Observações',
                alignLabelWithHint: true
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