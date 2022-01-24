import 'package:get/route_manager.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/categories/categoriesaddupdate/categoriesaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_binding.dart';
import 'package:habito_invest_app/app/modules/categories/categorieslist/categorieslist_page.dart';
import 'package:habito_invest_app/app/modules/expense/expenseadd/expenseadd_binding.dart';
import 'package:habito_invest_app/app/modules/expense/expenseadd/expenseadd_page.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_binding.dart';
import 'package:habito_invest_app/app/modules/expense/expenselist/expenselist_page.dart';
import 'package:habito_invest_app/app/modules/expense/expenseupdate/expenseupdate_binding.dart';
import 'package:habito_invest_app/app/modules/expense/expenseupdate/expenseupdate_page.dart';
import 'package:habito_invest_app/app/modules/goals/goalslist/goalslist_binding.dart';
import 'package:habito_invest_app/app/modules/goals/goalslist/goalslist_page.dart';
import 'package:habito_invest_app/app/modules/goals/goalsupdate/goalsupdate_page.dart';
import 'package:habito_invest_app/app/modules/goals/goalsupdate/goalsaupdate_binding.dart';
import 'package:habito_invest_app/app/modules/goals/goalswarning/goalswarning_binding.dart';
import 'package:habito_invest_app/app/modules/goals/goalswarning/goalswarning_page.dart';
import 'package:habito_invest_app/app/modules/home/home_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomeaddupdate/incomeaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_binding.dart';
import 'package:habito_invest_app/app/modules/income/incomelist/incomelist_page.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_binding.dart';
import 'package:habito_invest_app/app/modules/investment/investmentaddupdate/investmentaddupdate_page.dart';
import 'package:habito_invest_app/app/modules/investment/investmentlist/investmentlist_binding.dart';
import 'package:habito_invest_app/app/modules/investment/investmentlist/investmentlist_page.dart';
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
      page: () => GoalsListPage(),
      binding: GoalsListBinding(),
    ),
    GetPage(
      name: Routes.GOALS_DEFINITION,
      page: () => GoalsUpdatePage(),
      binding: GoalsUpdateBinding(),
    ),
    GetPage(
      name: Routes.GOALS_WARNING,
      page: () => GoalsWarningPage(),
      binding: GoalsWarningBinding(),
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
      name: Routes.EXPENSE_ADD,
      page: () => ExpenseAddPage(),
      binding: ExpenseAddBinding(),
    ),
    GetPage(
      name: Routes.EXPENSE_UPDATE,
      page: () => ExpenseUpdatePage(),
      binding: ExpenseUpdateBinding(),
    ),
    GetPage(
      name: Routes.INVESTMENT_LIST,
      page: () => InvestmentList(),
      binding: InvestmentListBinding(),
    ),
    GetPage(
      name: Routes.INVESTMENT_ADDUPDATE,
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
