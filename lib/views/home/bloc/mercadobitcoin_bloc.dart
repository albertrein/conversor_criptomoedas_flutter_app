import 'dart:async';

import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';

import '../../../services/mercadobitcoin_api_service.dart';

class MercadoBitcoinBloc{
  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get entrada => _streamController.sink;
  Stream<CriptoMoeda> get saida => _streamController.stream.asyncMap((event) => _buscaCotacaoMoeda());

  Future<CriptoMoeda> _buscaCotacaoMoeda() async{
    MercadoBitcoin apiCriptomoedaBitcoin = MercadoBitcoin('BTC');
    CriptoMoeda response = await apiCriptomoedaBitcoin.getTickerCoin();
    return response;
  }
}