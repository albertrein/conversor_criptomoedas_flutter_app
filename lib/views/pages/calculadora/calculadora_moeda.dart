import 'package:flutter/material.dart';
import 'counter.dart';

class CalculadoraMoeda extends StatefulWidget {
  const CalculadoraMoeda({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculadoraMoeda();
  }
}

class _CalculadoraMoeda extends State<CalculadoraMoeda> {
  bool _isFavorited = true;
   var _searchCepController = TextEditingController();
   bool _enableField = true;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                            'BTC',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Bitcoin'),
                          SizedBox(
                            height: 20.0,
                          ),
                          CounterDesign(),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Dados',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Text('Volume:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text('123123123')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Venda:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text('123123123')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Compra:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text('123123123')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Alta:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                              Text('123123123')
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Conversor',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text('Converter Reais para BTC'),
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
                                    hintText: "Reais",
                                    fillColor: Colors.white70
                                  ),
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  controller: _searchCepController,
                                  enabled: _enableField,
                                ),
                              ),
                              Text("BTC ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            height: 60.0,
                            child: RaisedButton(
                              elevation: 0.0,
                              color: Colors.amber[300],
                              onPressed: () {},
                              child: Text(
                                'Converter',
                                style:
                                  TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ), 
                          Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text('Converter BTC para Reais'),
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
                                    hintText: "BTC",
                                    fillColor: Color.fromARGB(179, 24, 23, 23)
                                  ),
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  controller: _searchCepController,
                                  enabled: _enableField,
                                ),
                              ),
                              Text("R\$ ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            height: 60.0,
                            child: RaisedButton(
                              elevation: 0.0,
                              color: Colors.amber[300],
                              onPressed: () {},
                              child: Text(
                                'Converter',
                                style:
                                  TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
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