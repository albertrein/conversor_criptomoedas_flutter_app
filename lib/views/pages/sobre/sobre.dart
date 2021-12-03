import 'package:flutter/material.dart';


class Sobre extends StatelessWidget {
  TextEditingController _siglaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,      
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
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
        body: Center(
          child: Column(
            children: [     
              Flexible(child: Text("Desenvolvido por: Guilherme Reinheimer", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),),
              SizedBox(
                width: 15.0,
              ),
              Flexible(child: Text('Professor: Ramon', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
              SizedBox(
                width: 15.0,
              ),
              Flexible(child: Text('Ano: 2021', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),)
            ],
          ),
        )
      ),
    );
  }
}