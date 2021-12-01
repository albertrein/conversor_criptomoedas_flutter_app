import 'package:http/http.dart' as http;
import '../models/criptomoeda_model.dart';
import 'dart:convert';

class MercadoBitcoin {
  String _moeda = "";

  MercadoBitcoin(String novaMoeda){
    setMoeda(novaMoeda);
  }

  setMoeda(String novaMoeda){
    _moeda = novaMoeda;
  }

  Future<CriptoMoeda> getTickerCoin() async {
    final Uri uri = Uri.parse('https://www.mercadobitcoin.net/api/$_moeda/ticker/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return CriptoMoeda.fromMap(json.decode(response.body)['ticker']);      
    } else {
      return CriptoMoeda.emptyClass();
    }    
  }
}