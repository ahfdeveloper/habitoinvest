import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors/app_colors.dart';

class AppTextStyles {
  // Estilo da expressão "Meu saldo" na appBar na HomePage
  static final TextStyle appBarTextSaldo = GoogleFonts.notoSans(
    color: AppColors.themeColor,
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );

  // Estilo do valor do saldo que aparece na appBar da HomePage
  static final TextStyle appBarNumberSaldo = GoogleFonts.notoSans(
    color: AppColors.themeColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  // Estilo do texto presente nas appBar de modo geral quando a mesma tem cor clara
  static final TextStyle appBarTextDark = GoogleFonts.notoSans(
    color: AppColors.themeColor,
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
  );

  // Estilo do texto presente nas appBar de modo geral quando a mesma tem cor clara
  static final TextStyle percentageChartHome = GoogleFonts.notoSans(
    color: AppColors.grey800,
    fontSize: 21.0,
    fontWeight: FontWeight.w700,
  );

  // Estilo do texto presente nas appBar de modo geral quando a mesma tem cor escura
  static final TextStyle appBarTextLight = GoogleFonts.notoSans(
    color: AppColors.white,
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
  );

  // Estilo do título do card de projeção de despesas
  static final TextStyle titleCardProjection = GoogleFonts.notoSans(
    color: AppColors.bodyTextPagesColor,
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  // Estilo padrão usado no corpo das páginas quando o background é claro
  static final TextStyle textCardProjection = GoogleFonts.notoSans(
    color: AppColors.bodyTextPagesColor,
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
  );

  // Estilo padrão usado no corpo das páginas quando o background é claro
  static final TextStyle generallyTextDarkBody = GoogleFonts.notoSans(
    color: AppColors.bodyTextPagesColor,
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
  );

  // Estilo padrão usado no corpo das páginas quando o background é claro
  static final TextStyle generallyLittleTextDarkBody = GoogleFonts.notoSans(
    color: AppColors.bodyTextPagesColor,
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
  );

  // Estilo padrão usado no corpo das páginas quando o background é escuro
  static final TextStyle generallyTextLightBody = GoogleFonts.notoSans(
    color: AppColors.white,
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
  );

  //Estilo do cabeçalho presente no card de objetivos
  static final TextStyle cardHeadTextGoal = GoogleFonts.notoSans(
    color: AppColors.bodyTextPagesColor,
    fontSize: 16.0,
  );

  // Estilo do valor presente no card de objetivos
  static final TextStyle cardValueTextGoal = GoogleFonts.notoSans(
    color: AppColors.grey800,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  // Estilo do rodapé presente no card de objetivos
  static final TextStyle cardFeatTextGoal = GoogleFonts.notoSans(
    color: AppColors.bodyTextPagesColor,
    fontSize: 13.0,
  );

  // Estilo do texto na página de boas vindas
  static final TextStyle titleHome = GoogleFonts.lexendDeca(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.themeColor,
  );

  // Estilo no botão de login social
  static final buttonGray = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  // Estilo no botão de login social
  static final buttonWhite = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  // Estilo do texto nos formulários
  static final input = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.input,
  );

  // Estilo usado na página Welcome
  static final textBlack = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.themeColor,
  );

  // Estilo usado na tela de inserção do valor da operação de despesa
  static final valueExpenseOperationStyle = GoogleFonts.notoSans(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColors.expenseColor,
  );

  // Estilo usado na tela de inserção do valor da operação de receita
  static final valueIncomeOperationStyle = GoogleFonts.notoSans(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColors.incomeColor,
  );

  // Estilo usado na tela de inserção do valor da operação de investimento
  static final valueInvestmentOperationStyle = GoogleFonts.notoSans(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColors.investColor,
  );

  // Estilo usado no valor inserido das metas
  static final valueGoals = GoogleFonts.notoSans(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    color: AppColors.themeColor,
  );

  static final parametersText = GoogleFonts.notoSans(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: AppColors.bodyTextPagesColor,
  );
}
