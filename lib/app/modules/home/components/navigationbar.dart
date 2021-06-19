import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/modules/home/home_controller.dart';

class NavigationBar extends StatelessWidget {
  final HomeController _controller = HomeController();

  @override
  Widget build(Object context) {
    return Obx(
      () => BottomNavyBar(
        selectedIndex: _controller.currentIndex,
        showElevation: true,
        itemCornerRadius: 20.0,
        curve: Curves.easeIn,
        onItemSelected: _controller.changePage,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Início'),
            activeColor: AppColors.themeColor,
            inactiveColor: AppColors.grey800,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.credit_card),
            title: Text('Gastos'),
            activeColor: AppColors.expenseColor,
            inactiveColor: AppColors.grey800,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Metas'),
            activeColor: AppColors.investcolor,
            inactiveColor: AppColors.grey800,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
