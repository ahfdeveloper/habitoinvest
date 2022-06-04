import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habito_invest_app/app/core/values/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_functions.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse('https://github.com/ahfdeveloper/habitoinvest');
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => cancel()),
        backgroundColor: AppColors.themeColor,
        title: Text('Sobre...', style: AppTextStyles.appBarTextLight),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Text('Especialização Lato Sensu', style: GoogleFonts.notoSans(fontSize: 19.0)),
                Text('em Desenvolvimento de', style: GoogleFonts.notoSans(fontSize: 19.0)),
                Text('Sistemas para Dispositivos Móveis', style: GoogleFonts.notoSans(fontSize: 19.0)),
                Text('SDM', style: GoogleFonts.notoSans(fontSize: 19.0)),
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(child: Container(height: MediaQuery.of(context).size.height * 0.16, child: Image.asset(AppImages.logo))),
                      Expanded(child: Container(height: MediaQuery.of(context).size.height * 0.16, child: Image.asset(AppImages.ifsp))),
                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                Text('Hábito Invest', style: GoogleFonts.notoSans(fontSize: 25.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Text('Aplicativo de finanças focado em metas', style: GoogleFonts.notoSans(fontSize: 16.0)),
                Text('de despesas não essenciais e investimentos', style: GoogleFonts.notoSans(fontSize: 16.0)),
                SizedBox(height: 80.0),
                Text('André Henrique de Freitas', style: GoogleFonts.notoSans(fontSize: 15.0)),
                Text('Orentador: Prof. Dr. Carlos José de A. Pereira', style: GoogleFonts.notoSans(fontSize: 14.0)),
                Text('2022', style: GoogleFonts.notoSans(fontSize: 15.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.backgroundColor,
        height: 55.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Código Fonte: ', style: GoogleFonts.notoSans(fontSize: 12.0)),
              TextButton(
                onPressed: () async {
                  if (!await launchUrl(_url)) throw 'Página não pode ser aberta';
                },
                child: Text(
                  'https://github.com/ahfdeveloper/habitoinvest',
                  style: GoogleFonts.notoSans(fontSize: 12.0, color: Colors.blue[600], decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
