import 'package:flutter/material.dart';
import 'components/drawer.dart';


class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.transparent,
        title: Text('Hábito Invest', style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawerHome(),
    );

  }
}