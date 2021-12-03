import 'package:conversor_criptomoedas/views/pages/moedas_persistencia/moedas_persistencia_page.dart';
import 'package:flutter/material.dart';
import 'package:conversor_criptomoedas/helper/moeda_helper.dart';
import 'package:conversor_criptomoedas/models/moeda_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NovaMoeda extends StatelessWidget {
  TextEditingController _siglaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // Inglês
        const Locale('pt', ''), // Português
      ],
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.registration, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: AppLocalizations.of(context)!.initials,
                    fillColor: Colors.white70
                  ),
                  textInputAction: TextInputAction.done,
                  controller: _siglaController,
                  enabled: true,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: AppLocalizations.of(context)!.coinName,
                    fillColor: Colors.white70
                  ),
                  textInputAction: TextInputAction.done,
                  controller: _nomeController,
                  enabled: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: OutlinedButton(
                  onPressed: () async {
                    await _cadastrarMoeda();
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.register),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
   _cadastrarMoeda() async {
    if(_siglaController.text.isEmpty || _nomeController.text.isEmpty){
      return;
    }
    DatabaseHelper moedaHelper = DatabaseHelper();
    int ultimaSequencia = await moedaHelper.ultimaSequenciaCadastrada();
    ultimaSequencia = int.parse('$ultimaSequencia')+ 1;
    Moeda novaMoeda = Moeda(_siglaController.text, _nomeController.text, 1);
    return await moedaHelper.insereMoeda(novaMoeda);
  }
}