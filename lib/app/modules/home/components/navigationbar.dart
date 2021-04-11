import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/colors.dart';
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
            backgroundColor: THEMECOLOR,
            icon: Icon(Icons.dashboard, color: GENERALLYDEFAULTCOLOR),
            activeIcon: Icon(Icons.dashboard, color: THEMECOLOR),
            title: Text('Início')
          ),

          BubbleBottomBarItem(
            backgroundColor: EXPENSECOLOR,
            icon: Icon(Icons.credit_card, color: GENERALLYDEFAULTCOLOR),
            activeIcon: Icon(Icons.credit_card, color: EXPENSECOLOR),
            title: Text('Projeção Gastos'),
          ),

          BubbleBottomBarItem(
            backgroundColor: INVESTCOLOR,
            icon: Image.asset('assets/pig_safe.png', color: GENERALLYDEFAULTCOLOR,),
            activeIcon: Image.asset('assets/pig_safe.png', color: INVESTCOLOR),
            title: Text('Projeção metas'),
          ),

        ],
      )
    );
  }

}