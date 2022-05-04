import 'package:get/route_manager.dart';
import 'package:habito_invest_app/app/modules/welcome/welcome_binding.dart';
import 'routes.dart';
import '../modules/categoriesaddupdate/categoriesaddupdate_binding.dart';
import '../modules/categoriesaddupdate/categoriesaddupdate_page.dart';
import '../modules/categorieslist/categorieslist_binding.dart';
import '../modules/categorieslist/categorieslist_page.dart';
import '../modules/expenseadd/expenseadd_binding.dart';
import '../modules/expenseadd/expenseadd_page.dart';
import '../modules/expenselist/expenselist_binding.dart';
import '../modules/expenselist/expenselist_page.dart';
import '../modules/expenseupdate/expenseupdate_binding.dart';
import '../modules/expenseupdate/expenseupdate_page.dart';
import '../modules/goalslist/goalslist_binding.dart';
import '../modules/goalslist/goalslist_page.dart';
import '../modules/goalsupdate/goalsaupdate_binding.dart';
import '../modules/goalsupdate/goalsupdate_page.dart';
import '../modules/goalswarning/goalswarning_binding.dart';
import '../modules/goalswarning/goalswarning_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/incomeaddupdate/incomeaddupdate_binding.dart';
import '../modules/incomeaddupdate/incomeaddupdate_page.dart';
import '../modules/incomelist/incomelist_binding.dart';
import '../modules/incomelist/incomelist_page.dart';
import '../modules/investmentaddupdate/investmentaddupdate_binding.dart';
import '../modules/investmentaddupdate/investmentaddupdate_page.dart';
import '../modules/investmentlist/investmentlist_binding.dart';
import '../modules/investmentlist/investmentlist_page.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_page.dart';
import '../modules/parameters/parameters_binding.dart';
import '../modules/parameters/parameters_page.dart';
import '../modules/projection/projection_binding.dart';
import '../modules/projection/projection_page.dart';
import '../modules/simulator/simulator_bindings.dart';
import '../modules/simulator/simulator_page.dart';
import '../modules/splashscreen/splashscreen_binding.dart';
import '../modules/splashscreen/splashscreen_page.dart';
import '../modules/userregister/register_binding.dart';
import '../modules/userregister/register_page.dart';
import '../modules/welcome/welcome_page.dart';

class Pages {
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
      name: Routes.PROJECTION,
      page: () => ProjectionPage(),
      binding: ProjectionBinding(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
  ];
}
