// Classe com as rotas do app

abstract class Routes {
  // Splashscreen
  static const SPLASH = '/';
  // Login de Usuário
  static const LOGIN = '/login';
  // Registro de usuário
  static const REGISTER_USER = '/register';
  // Dashboard
  static const HOME = '/home';
  // Lista de Metas
  static const GOALS = '/goals';
  // Definir Metas
  static const GOALS_DEFINITION = '/goals_definition';
  // Aviso de Metas não cadastradas
  static const GOALS_WARNING = '/goals_warning';
  // Lista de Receitas
  static const INCOME_LIST = '/income_list';
  // Cadastro e atualização de Receitas
  static const INCOME_ADDUPDATE = '/income_addupdate';
  // Lista de Despesas
  static const EXPENSE_LIST = '/expense_list';
  // Cadastro e atualização de Despesas
  static const EXPENSE_ADD = '/expense_add';
  // Atualização de uma despesa
  static const EXPENSE_UPDATE = '/expense_update';
  // Lista de Investimentos
  static const INVESTMENT_LIST = '/invest_list';
  // Cadastro e atualização de Investimentos
  static const INVESTMENT_ADDUPDATE = '/invest_addupdate';
  //Lista de Categorias
  static const CATEGORIES_LIST = '/categories_list';
  // Cadastro e atualização de uma categoria
  static const CATEGORIES_ADDUPDATE = '/categories_addupdate';
  // Simulador de Investimentos
  static const SIMULATOR = '/simulator';
  // Cadastro de Parâmetros
  static const PARAMETERS = '/parameters';
  // Página de Boas vindas ao app com opções para Login
  static const WELCOME = '/welcome';
  //---------------------
  static const CATEGORIES_UPDATE = '/categories_update';
}
