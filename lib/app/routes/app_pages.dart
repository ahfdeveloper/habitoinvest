import 'package:get/route_manager.dart';
import 'package:habito_invest_app/app/modules/home/home_binding.dart';
import 'package:habito_invest_app/app/modules/login/login_binding.dart';
import 'package:habito_invest_app/app/modules/userregister/register_page.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:habito_invest_app/app/modules/goals/goals_page.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_page.dart';
import 'package:habito_invest_app/app/modules/home/home_page.dart';
import 'package:habito_invest_app/app/modules/initial/initial_page.dart';
import 'package:habito_invest_app/app/modules/login/login_page.dart';


class AppPages{
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => InitialPage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.REGISTER, page: () => RegisterPage()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.GOALS, page: () => GoalsPage()),
    GetPage(name: Routes.DEFINITION_GOALS, page: () => GoalsDefinitionPage())
  ];
}