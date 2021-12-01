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
    high : dadosJson['high'],
    vol : dadosJson['vol'],
    last : dadosJson['last'],
    buy : dadosJson['buy'],
    sell : dadosJson['sell'],
    open : dadosJson['open'],
    date : dadosJson['date']
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