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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            StreamBuilder<CriptoMoeda>(
              stream: bloc.saida,
              initialData: CriptoMoeda.emptyClass(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Text("Erro!");
                }
                CriptoMoeda? moeda = snapshot.data;
                if(moeda?.high == "" || moeda?.high == null){
                  return Text("");
                }
                return MoedaBlock('assets/images/bitcoin.png', moeda);
              },
            ),
            /*MoedaBlock('assets/images/bitcoin.png', ),
            MoedaBlock('assets/images/etherium.png', )*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          bloc.entrada.add('');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
