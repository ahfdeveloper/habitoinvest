import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
import 'package:habito_invest_app/app/global/widgets/constants.dart';
import 'package:intl/intl.dart';


class ExpenseAddUpdate extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EXPENSECOLOR,
        title: Text('Cadastrar Despesa'),
        actions: [
          IconButton(
            onPressed: () {  },
            icon: Icon(Icons.cancel, color: TEXTCOLORLIGHT),
          ),

          IconButton(
            onPressed: () { },
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
              style: TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Data',
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                Future <DateTime> selectDate = showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(2021), 
                  lastDate: DateTime(2050),
                  builder: (BuildContext context, Widget child){
                    return Theme(data: ThemeData.light().copyWith(
                      primaryColor: EXPENSECOLOR,
                      accentColor: EXPENSECOLOR,
                    ), 
                    child: child);
                  }
                );
                if(selectDate != null){
                  
                }
              },
              initialValue: DateFormat('dd/MM/yyyy').format(DateTime.now()),
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
                alignLabelWithHint: true,
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