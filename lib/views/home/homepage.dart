import 'package:conversor_criptomoedas/helper/theme/theme_helper.dart';
import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:conversor_criptomoedas/views/home/components/menu_component.dart';
import 'package:flutter/material.dart';
import 'bloc/mercadobitcoin_bloc.dart';
import 'components/bloco_moeda.dart';
import 'package:conversor_criptomoedas/helper/moeda_helper.dart';
import 'package:conversor_criptomoedas/models/moeda_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.colorBackgroundAppBar}) : super(key: key);

  final String title;
  final int colorBackgroundAppBar;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MercadoBitcoinBloc bloc = MercadoBitcoinBloc();
  List<Widget>_controllerListMoedasBlocks = [];
  DatabaseHelper moedaHelper = DatabaseHelper();

  @override
  void initState(){
    _inicializaBlocosMoedas();
    _controllerListMoedasBlocks.add(_circularLoading());
  }

  void _inicializaBlocosMoedas()async {
    List<Moeda> listaMoedas =  await moedaHelper.moedasOrdenadasPorSequencia();
    print(listaMoedas);
    listaMoedas.forEach((element) {
      print(element.sigla);
      bloc.entrada.add(element.sigla+','+element.nome);      
    });
    _controllerListMoedasBlocks.removeLast();
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(widget.colorBackgroundAppBar),
        actions: [
          IconButton(
              icon: const Icon(Icons.restart_alt_outlined, color: Colors.white,),
              iconSize: 30,
              onPressed: () {
                //Reload itens
                _controllerListMoedasBlocks = [];
                _controllerListMoedasBlocks.add(_circularLoading());
                _inicializaBlocosMoedas();
              },
            )
        ]
      ),
      body: 
          StreamBuilder<CriptoMoeda>(
            stream: bloc.saida,
            initialData: CriptoMoeda.emptyClass(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return const Text("Error!");
              }
              CriptoMoeda? moeda = snapshot.data;
              
              if(!moeda!.isClassEmpty()){
                _controllerListMoedasBlocks.add(MoedaBlock(moeda));                
              }              
              return ListView.builder(
                itemCount: _controllerListMoedasBlocks.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Column(
                    children: [
                      _controllerListMoedasBlocks[index]
                    ],
                  );
                }
              );
            },
          ),
    );
  }
}
