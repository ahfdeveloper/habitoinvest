import 'package:get/route_manager.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_binding.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_page.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/expense/expenseaddupdate/expenseaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_binding.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_page.dart';
import 'package:habito_invest_app/app/modules/goals/goals_binding.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_binding.dart';
import 'package:habito_invest_app/app/modules/home/home_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_page.dart';
import 'package:habito_invest_app/app/modules/invest/investaddupdate/investaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/invest/investaddupdate/investaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/invest/investlist/investlist_binding.dart';
import 'package:habito_invest_app/app/modules/invest/investlist/investlist_page.dart';
import 'package:habito_invest_app/app/modules/login/login_binding.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_binding.dart';
import 'package:habito_invest_app/app/modules/parameters/parameters_page.dart';
import 'package:habito_invest_app/app/modules/simulator/simulator_bindings.dart';
import 'package:habito_invest_app/app/modules/simulator/simulator_page.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_binding.dart';
import 'package:habito_invest_app/app/modules/userregister/register_binding.dart';
import 'package:habito_invest_app/app/modules/userregister/register_page.dart';
import 'package:habito_invest_app/app/modules/welcome/welcome_page.dart';
import 'package:habito_invest_app/app/routes/app_routes.dart';
import 'package:habito_invest_app/app/modules/goals/goals_page.dart';
import 'package:habito_invest_app/app/modules/goalsdefinition/goalsdefinition_page.dart';
import 'package:habito_invest_app/app/modules/home/home_page.dart';
import 'package:habito_invest_app/app/modules/splashscreen/splashscreen_page.dart';
import 'package:habito_invest_app/app/modules/login/login_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_USER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.GOALS,
      page: () => GoalsPage(),
      binding: GoalsBinding(),
    ),
    GetPage(
      name: Routes.DEFINITION_GOALS,
      page: () => GoalsDefinitionPage(),
      binding: GoalsDefinitionBinding(),
    ),
    GetPage(
      name: Routes.INCOME_LIST,
      page: () => IncomeList(),
      binding: IncomeListBinding(),
    ),
    GetPage(
      name: Routes.INCOME_ADDUPDATE,
      page: () => IncomeAddUpdatePage(),
      binding: IncomeAddUpdateBinding(),
    ),
    GetPage(
      name: Routes.EXPENSE_LIST,
      page: () => ExpenseList(),
      binding: ExpenseListBinding(),
    ),
    GetPage(
      name: Routes.EXPENSE_ADDUPDATE,
      page: () => ExpenseAddUpdatePage(),
      binding: ExpenseAddUpdateBinding(),
    ),
    GetPage(
      name: Routes.INVEST_LIST,
      page: () => InvestList(),
      binding: InvestListBinding(),
    ),
    GetPage(
      name: Routes.INVEST_ADDUPDATE,
      page: () => InvestAddUpdatePage(),
      binding: InvestAddUpdateBinding(),
    ),
    GetPage(
      name: Routes.CATEGORIES_LIST,
      page: () => CategoriesList(),
      binding: CategoriesListBinding(),
    ),
    GetPage(
      name: Routes.CATEGORIES_ADDUPDATE,
      page: () => CategoriesAddUpdatePage(),
      binding: CategoriesAddUpdateBinding(),
    ),
    GetPage(
      name: Routes.SIMULATOR,
      page: () => SimulatorPage(),
      binding: SimulatorBindings(),
    ),
    GetPage(
      name: Routes.PARAMETERS,
      page: () => ParametersPage(),
      binding: ParametersBinding(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
    ),
  ];
}
