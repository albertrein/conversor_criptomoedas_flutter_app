import 'package:conversor_criptomoedas/helper/moeda_helper.dart';
import 'package:conversor_criptomoedas/models/moeda_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoedasPersistencia extends StatefulWidget {
  
  const MoedasPersistencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoedasPersistencia();
  }
}

class _MoedasPersistencia extends State<MoedasPersistencia> {
  TextEditingController _siglaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  DatabaseHelper moedaHelper = DatabaseHelper();
  List<Moeda> noteList = [];
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
                          return Text('Loading');
                        } else {
                          if (snapshot.data.length < 1) {
                            return Center(
                              child: Text('No Messages, Create New one'),
                            );
                          }
                          noteList = snapshot.data;
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
                            onReorder: _onReorder,
                          );
                        }
                      }))
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: _insereMoeda,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
      ),
    );
  }
  void _onReorder(int oldIndex, int newIndex) async {
    if (newIndex > noteList.length) newIndex = noteList.length;
    if (oldIndex < newIndex) newIndex -= 1;
    final Moeda item = noteList[oldIndex];
    final Moeda itemNovo = noteList[newIndex];

    await moedaHelper.alteraSequenciaMoedas(item, newIndex);
    await moedaHelper.alteraSequenciaMoedas(itemNovo, oldIndex);
    setState(() {      
      noteList.removeAt(oldIndex);
      noteList.insert(newIndex, item);
      _future = moedaHelper.moedasOrdenadasPorSequencia();
    });
  }

  void _insereMoeda() async {   
    Moeda novaMoeda = Moeda("USD", "USDD", 3);
    await moedaHelper.insereMoeda(novaMoeda);
    var saidavar  = await  moedaHelper.listaDeTodosAsMoedas();
    setState(() {
      _future = moedaHelper.moedasOrdenadasPorSequencia();
    });
  }

  void _excluirMoeda(String siglaMoedaExclusao) async {
    await moedaHelper.excluiMoeda(siglaMoedaExclusao);
  }
}