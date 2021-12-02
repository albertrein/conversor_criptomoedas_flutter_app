class CriptoMoeda{
  String high;
  String vol;
  String last;
  String buy;
  String sell;
  String open;
  int date;
  String? siglaMoeda;
  String? nomeMoeda;

  CriptoMoeda({
   required this.high,
   required this.vol,
   required this.last,
   required this.buy,
   required this.sell,
   required this.open,
   required this.date
  });

  factory CriptoMoeda.fromMap(Map<String, dynamic> dadosJson) => CriptoMoeda(
    high : dadosJson.containsKey("high") ? dadosJson['high']: "",
    vol : dadosJson.containsKey("vol")?  dadosJson['vol']: "",
    last : dadosJson.containsKey("last")? dadosJson['last']: "",
    buy : dadosJson.containsKey("buy")?  dadosJson['buy']: "",
    sell : dadosJson.containsKey("sell")? dadosJson['sell']: "",
    open : dadosJson.containsKey("open")? dadosJson['open']: "",
    date : dadosJson.containsKey("date")? dadosJson['date']: 0,
  );

  factory CriptoMoeda.emptyClass() => CriptoMoeda(
    high : "",
    vol :  "",
    last : "",
    buy :  "",
    sell : "",
    open : "",
    date : 0
  );

  bool isClassEmpty(){
    if(high == "" && vol == "" && last == "" && buy == "" && sell == "" && open == "" && date == 0){
      return true;
    }
    return false;
  }

  @override
  String toString() {
    String dadosObjeto = "";
    dadosObjeto += high + " ";
    dadosObjeto += vol + " ";
    dadosObjeto += last + " ";
    dadosObjeto += buy + " ";
    dadosObjeto += sell + " ";
    dadosObjeto += open + " ";
    dadosObjeto += date.toString() + " ";
    return dadosObjeto;
  }
}