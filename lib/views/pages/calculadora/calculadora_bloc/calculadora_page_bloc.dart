import 'dart:async';
import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:conversor_criptomoedas/views/pages/calculadora/calculadora_moeda.dart';
import 'package:intl/intl.dart';


class CalculadoraBloc{
  String? valorCompra = "";
  String conversaoReaisParaCriptomoeda = "";
  String conversaoCriptomoedaParaReais = "";

  final oCcy = NumberFormat("#,##0.00000", "pt_BR");

  final StreamController<String> _streamController = StreamController<String>();

  Sink<String> get inputReal => _streamController.sink;
  Stream<double> get outputMoeda => _streamController.stream
  .where((String stringEmReais) => stringEmReais.isNotEmpty)
  .asyncMap((stringEmReais) => _converteRealParaCriptomoeda(stringEmReais));
  
  final StreamController<String> _streamControllerCripto = StreamController<String>();
  Sink<String> get inputCriptomoeda => _streamControllerCripto.sink;
  Stream<double> get outputCriptomoeda => _streamControllerCripto.stream
  .where((String stringQtdCriptomoeda) => stringQtdCriptomoeda.isNotEmpty)
  .asyncMap((stringQtdCriptomoeda) => _converteCriptomoedaParaReal(stringQtdCriptomoeda));



  Future<double> _converteRealParaCriptomoeda(String stringEmReais) async{
    double valorReais = double.parse(stringEmReais);
    if(valorReais == null){
      return 0.0;
    }
    double valorCriptomoeda = double.parse(valorCompra!);
    if(valorCriptomoeda == null){
      return 0.0;
    }
    conversaoReaisParaCriptomoeda = oCcy.format(valorReais/valorCriptomoeda);
    return valorReais / valorCriptomoeda;
  }
  
  Future<double> _converteCriptomoedaParaReal(String stringQtdCriptomoeda) async{
    double qtdCriptomoeda = double.parse(stringQtdCriptomoeda);
    if(qtdCriptomoeda == null){
      return 0.0;
    }

    double valorCriptomoeda = double.parse(valorCompra!);
    if(valorCriptomoeda == null){
      return 0.0;
    }
    conversaoCriptomoedaParaReais = oCcy.format(qtdCriptomoeda*valorCriptomoeda);
    return qtdCriptomoeda / valorCriptomoeda;
  }
  
  void converteReaisParaCriptomoeda(String reais){
    inputReal.add(reais);
  }
  
  void converteCriptomoedaParaReais(String criptomoedaString){
    inputCriptomoeda.add(criptomoedaString);
  }
}