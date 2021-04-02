import 'package:get/route_manager.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_page.dart';
import 'package:habito_invest_app/app/modules/home/home_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_page.dart';
import 'package:habito_invest_app/app/modules/invest/investlist/investlist_page.dart';
import 'package:habito_invest_app/app/modules/login/login_binding.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_binding.dart';
import 'package:habito_invest_app/app/modules/userregister/register_page.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:habito_invest_app/app/modules/goals/goals_page.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_page.dart';
import 'package:habito_invest_app/app/modules/home/home_page.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_page.dart';
import 'package:habito_invest_app/app/modules/login/login_page.dart';


class AppPages{
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => SplashScreenPage(), binding: SplashScreenBinding()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.REGISTER_USER, page: () => RegisterPage()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.GOALS, page: () => GoalsPage()),
    GetPage(name: Routes.DEFINITION_GOALS, page: () => GoalsDefinitionPage()),
    GetPage(name: Routes.INCOME_LIST, page: () => IncomeList()),
    GetPage(name: Routes.INCOME_ADD, page: () => IncomeAddUpdate()),
    GetPage(name: Routes.EXPENSE_LIST, page: () => ExpenseList()),
    GetPage(name: Routes.INVEST_LIST, page: () => InvestList())
  ];
}