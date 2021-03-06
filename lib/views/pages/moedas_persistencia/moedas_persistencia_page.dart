import 'package:conversor_criptomoedas/helper/moeda_helper.dart';
import 'package:conversor_criptomoedas/models/moeda_model.dart';
import 'package:conversor_criptomoedas/models/theme_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart';

import '../insercao_moedas/nova_moeda.dart';

class MoedasPersistencia extends StatefulWidget {
  final ThemeConfigData dadosConfiguracaoTema;

  MoedasPersistencia(this.dadosConfiguracaoTema);

  @override
  State<StatefulWidget> createState() {
    return _MoedasPersistencia();
  }
}

class _MoedasPersistencia extends State<MoedasPersistencia> {
  DatabaseHelper moedaHelper = DatabaseHelper();
  List<Moeda> moedaList = [];
  late Future<List<Moeda>> _future;

  @override
  void initState() {
    _future = moedaHelper.moedasOrdenadasPorSequencia();
  }

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
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: widget.dadosConfiguracaoTema.getBackgroundAppBarColor,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.restart_alt_outlined),
              iconSize: 30,
              onPressed: () {
                setState(() {
                  _future = moedaHelper.moedasOrdenadasPorSequencia();                  
                });
              },
            )
        ]
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height *0.882,
                  child: FutureBuilder(
                      future: _future,
                      builder: (BuildContext context, AsyncSnapshot 
                       snapshot) {
                        if (snapshot.data == null) {
                          return Text(AppLocalizations.of(context)!.loading);
                        } else {
                          if (snapshot.data.length < 1) {
                            return Center(
                              child: Text(AppLocalizations.of(context)!.emptyList),
                            );
                          }
                          moedaList = snapshot.data;
                          return ReorderableListView(
                            children: List.generate(
                              snapshot.data.length,
                              (index) {
                                return ListTile(
                                  key: Key('$index'),
                                  title: Text(
                                    snapshot.data[index].sigla,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: 
                                 Text(snapshot.data[index].nome,
                                      maxLines: 4),
                                  trailing: InkWell(
                                    child: Icon(Icons.close,
                                        color: Colors.red),
                                    onTap: () {                                    
                                      _excluirMoeda(snapshot.data[index].sigla);
                                      setState(() {
                                        _future = moedaHelper.moedasOrdenadasPorSequencia();
                                      });
                                    },
                                  ), 
                                  onTap: () {},
                                );
                              },
                            ).toList(),
                            onReorder: _onReordenamento,
                          );
                        }
                      }
                    )
                  ),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => NovaMoeda())); },
            child: Icon(Icons.add,),
            backgroundColor: Colors.black,
          ),
      ),
    );
  }
  void _onReordenamento(int oldIndex, int newIndex) async {
    if (newIndex > moedaList.length) newIndex = moedaList.length;
    if (oldIndex < newIndex) newIndex -= 1;
    final Moeda item = moedaList[oldIndex];
    final Moeda itemNovo = moedaList[newIndex];

    await moedaHelper.alteraSequenciaMoedas(item, newIndex);
    await moedaHelper.alteraSequenciaMoedas(itemNovo, oldIndex);
    setState(() {      
      moedaList.removeAt(oldIndex);
      moedaList.insert(newIndex, item);
      _future = moedaHelper.moedasOrdenadasPorSequencia();
    });
  }

  void _excluirMoeda(String siglaMoedaExclusao) async {
    await moedaHelper.excluiMoeda(siglaMoedaExclusao);
  }

  
}