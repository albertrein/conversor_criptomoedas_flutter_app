import 'dart:convert';

import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:conversor_criptomoedas/services/mercadobitcoin_api_service.dart';
import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>> moedas = [{'sigla':'BTC', 'nome': 'Bitcoin'}, {'sigla':'ETH', 'nome':'Etherium'}];

  @override
  void initState() {
    //Inicializa loading
    //Carrega os estados iniciais aqui
    inicializaBlocosMoedas();
  }

  void inicializaBlocosMoedas() async {
    moedas.forEach((element) {
      print(element['sigla']);
      bloc.entrada.add(element['sigla']+','+element['nome']);
    });
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
              if(moeda?.high == "" || moeda?.high == null){
                return const Text("");
              }
              //return MoedaBlock('assets/images/bitcoin.png', moeda);
              
              _controllerListMoedasBlocks.add(MoedaBlock(moeda));
              return ListView.builder(
                itemCount: _controllerListMoedasBlocks.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return _controllerListMoedasBlocks[index];
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
