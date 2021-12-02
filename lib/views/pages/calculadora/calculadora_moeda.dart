import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:flutter/material.dart';
import 'calculadora_bloc/calculadora_page_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculadoraMoeda extends StatefulWidget {
  late final CriptoMoeda? moeda;

  
  CalculadoraMoeda({Key? key, this.moeda}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculadoraMoeda();
  }
}

class _CalculadoraMoeda extends State<CalculadoraMoeda> {
  TextEditingController _reaisController = TextEditingController();
  TextEditingController _moedaController = TextEditingController();
  CalculadoraBloc calcBloc = CalculadoraBloc();
  @override
  void initState() {
    calcBloc.valorCompra = widget.moeda!.buy;
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
          backgroundColor: Colors.transparent,
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
        backgroundColor: Colors.transparent,
        body: ListView(
          reverse: true,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )
                  ),                  
                  width: 500,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            widget.moeda!.siglaMoeda!,
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(widget.moeda!.nomeMoeda!,),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.data,
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.vol+': ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text(widget.moeda!.vol)
                            ],
                          ),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.sell+': ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text(widget.moeda!.sell)
                            ],
                          ),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.buy+': ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text(widget.moeda!.buy)
                            ],
                          ),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.high+': ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text(widget.moeda!.high)
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.converter,
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(AppLocalizations.of(context)!.brlTo+' '+widget.moeda!.siglaMoeda!),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.grey[800]),
                                    hintText: AppLocalizations.of(context)!.brl,
                                    fillColor: Colors.white70
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  controller: _reaisController,
                                  enabled: true,
                                ),
                              ),
                              StreamBuilder(
                                stream: calcBloc.outputMoeda,
                                initialData: Text(widget.moeda!.siglaMoeda!, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                builder: (context, snapshot){
                                  if(snapshot.hasError){
                                    return Text(widget.moeda!.siglaMoeda!, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
                                  }
                                  return Flexible(
                                    child: Text(widget.moeda!.siglaMoeda!+": "+calcBloc.conversaoReaisParaCriptomoeda, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                                  );
                                },
                              ),                              
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Semantics(
                            child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                                height: 60.0,
                                child: RaisedButton(
                                  elevation: 0.0,
                                  color: Colors.amber[300],
                                  onPressed: () {
                                    calcBloc.converteReaisParaCriptomoeda(_reaisController.text);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.converter,
                                    style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            label: AppLocalizations.of(context)!.converterbutton,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text('Converter '+widget.moeda!.nomeMoeda!+' para Reais'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    filled: true,
                                    hintText: widget.moeda!.siglaMoeda,
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  controller: _moedaController,
                                  enabled: true,
                                ),
                              ),
                              StreamBuilder(
                                stream: calcBloc.outputCriptomoeda,
                                initialData: const Text("R\$", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                builder: (context, snapshot){
                                  if(snapshot.hasError){
                                    return const Text("R\$", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
                                  }
                                  return Flexible(
                                    child: Text("R\$: "+calcBloc.conversaoCriptomoedaParaReais, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Semantics(
                            child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                              height: 60.0,
                              child: RaisedButton(
                                elevation: 0.0,
                                color: Colors.amber[300],
                                onPressed: () {calcBloc.converteCriptomoedaParaReais(_moedaController.text);},
                                child: Text(
                                  AppLocalizations.of(context)!.converter,
                                  style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            label: AppLocalizations.of(context)!.converterbutton,
                          ),                          
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}