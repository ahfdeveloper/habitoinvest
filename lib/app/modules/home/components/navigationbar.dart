import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';

class NavigationBar extends StatelessWidget{
  final HomeController _controller = HomeController();
  
  @override
  Widget build(Object context) {
    return Obx(
      () => BubbleBottomBar(
        hasNotch: true,
        opacity: .1 ,
        currentIndex: _controller.currentIndex,
        onTap: _controller.changePage,
        elevation: 8,

        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.blue[700],
            icon: Icon(Icons.dashboard, color: Colors.black),
            activeIcon: Icon(Icons.dashboard, color: Colors.blue[700]),
            title: Text('Início')
          ),

          BubbleBottomBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.credit_card, color: Colors.black),
            activeIcon: Icon(Icons.dashboard, color: Colors.purple),
            title: Text('Ver aqui')
          ),

          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.view_list, color: Colors.black),
            activeIcon: Icon(Icons.dashboard, color: Colors.red),
            title: Text('Metas')
          ),
          
        ],
      )
    );
  }

}