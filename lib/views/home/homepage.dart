import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:conversor_criptomoedas/views/home/components/menu_component.dart';
import 'package:flutter/material.dart';
import 'bloc/mercadobitcoin_bloc.dart';
import 'components/bloco_moeda.dart';
import 'package:conversor_criptomoedas/helper/moeda_helper.dart';
import 'package:conversor_criptomoedas/models/moeda_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MercadoBitcoinBloc bloc = MercadoBitcoinBloc();
  List<Widget>_controllerListMoedasBlocks = [];
  DatabaseHelper moedaHelper = DatabaseHelper();
 
  List<Map<String, dynamic>> moedas = [
    {'sigla':'BTC', 'nome': 'Bitcoin'},
    {'sigla':'ETH', 'nome':'Etherium'},
    {'sigla':'ETI', 'nome':'DOges'},
    {'sigla':'LTC', 'nome':'Litecoin'},
    {'sigla':'ADA', 'nome':'Cardano'},
    {'sigla':'UNI', 'nome':'Uniswap'},
    {'sigla':'USDC', 'nome':'USD Coin'},
  ];

  @override
  void initState() {
    _inicializaBlocosMoedas();
    _controllerListMoedasBlocks.add(_circularLoading());
    
  }

  void _inicializaBlocosMoedas()async {
    print('asq');
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.restart_alt_outlined),
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
