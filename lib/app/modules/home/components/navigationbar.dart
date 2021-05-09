import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
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
            backgroundColor: Colors.black,
            icon: Icon(Icons.dashboard, color: AppColors.bodyTextPagesColor),
            activeIcon: Icon(Icons.dashboard, color: Colors.black),
            title: Text('Início')
          ),

          BubbleBottomBarItem(
            backgroundColor: EXPENSECOLOR,
            icon: Icon(Icons.credit_card, color: AppColors.bodyTextPagesColor),
            activeIcon: Icon(Icons.credit_card, color: EXPENSECOLOR),
            title: Text('Projeção Gastos'),
          ),

          BubbleBottomBarItem(
            backgroundColor: INVESTCOLOR,
            icon: Image.asset('assets/pig_safe.png', color: AppColors.bodyTextPagesColor,),
            activeIcon: Image.asset('assets/pig_safe.png', color: INVESTCOLOR),
            title: Text('Projeção metas'),
          ),

        ],
      ),
    );
  }
}