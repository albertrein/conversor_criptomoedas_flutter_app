import 'dart:async';

import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:flutter/services.dart';

import '../../../services/mercadobitcoin_api_service.dart';

class MercadoBitcoinBloc{
  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get entrada => _streamController.sink;
  Stream<CriptoMoeda> get saida => _streamController.stream.asyncMap((siglaMoeda) => _buscaCotacaoMoeda(siglaMoeda));

  Future<CriptoMoeda> _buscaCotacaoMoeda(String siglaMoeda) async{
    List siglaNomeMoeda = siglaMoeda.split(',');
    MercadoBitcoin apiCriptomoedaBitcoin = MercadoBitcoin(siglaNomeMoeda[0]);
    CriptoMoeda response = await apiCriptomoedaBitcoin.getTickerCoin();
    response.siglaMoeda = siglaNomeMoeda[0];
    response.nomeMoeda = siglaNomeMoeda[1];
    response.imagemMoeda = await getImagemIcone(siglaNomeMoeda[1]);
    return response;
  }
}

Future<String> getImagemIcone(String nomeMoeda) async {
  String imageLocation = "assets/images/";
  try {
    await rootBundle.load(imageLocation+nomeMoeda+".png");
    return imageLocation+nomeMoeda+".png";
  } catch (_) {
    return "assets/images/default.png";
  }
}
