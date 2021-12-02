import 'dart:convert';

import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:conversor_criptomoedas/services/mercadobitcoin_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bloc/mercadobitcoin_bloc.dart';
import 'components/bloco_moeda.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MercadoBitcoinBloc bloc = MercadoBitcoinBloc();
  List<Widget>_controllerListMoedasBlocks = [];
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
    //Inicializa loading
    _controllerListMoedasBlocks.add(_circularLoading());
    //Carrega os estados iniciais aqui
    _inicializaBlocosMoedas();
  }

  void _inicializaBlocosMoedas() {
    moedas.forEach((element) {
      print(element['sigla']);
      bloc.entrada.add(element['sigla']+','+element['nome']);      
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
          StreamBuilder<CriptoMoeda>(
            stream: bloc.saida,
            initialData: CriptoMoeda.emptyClass(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return const Text("Erro!");
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
                  //return _controllerListMoedasBlocks[index];
                }
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          bloc.entrada.add('ETH');
          //_controllerListView.add("G");
          /*setState(() {
            
          });*/
        },
        tooltip: 'Increment',
        child: const Icon(Icons.calculate_outlined),        
      ),
      
    );
  }
}
