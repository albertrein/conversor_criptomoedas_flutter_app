import 'package:conversor_criptomoedas/models/theme_config_model.dart';
import 'package:conversor_criptomoedas/views/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/theme/theme_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ThemeConfigData dadosTema = ThemeConfigData.initializer(
    backgroundAppBarColor: await ThemeConfig.getAppBarBackgroundColor,
    backgroundBodyColor: await ThemeConfig.getBodyBackgroundColor
  );
  runApp(    
    MyApp(dadosConfiguracaoTema: dadosTema)
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.dadosConfiguracaoTema}) : super(key: key);

  ThemeConfigData dadosConfiguracaoTema;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pt', ''), 
      ],
      debugShowCheckedModeBanner: false,
      title: 'Conversor Criptomoeda App',
      theme: ThemeData(
        textTheme: TextTheme(bodyText1: TextStyle(),).apply(
          displayColor: Colors.black
        ),
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: dadosConfiguracaoTema.getBackgroundBodyColor
      ),
      home: MyHomePage(title: 'Conversor Criptomoeda', colorBackgroundAppBar: 4278190080),
    );
  }
}
