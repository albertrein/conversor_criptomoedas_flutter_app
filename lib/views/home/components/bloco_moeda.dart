import 'dart:io';

import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:conversor_criptomoedas/views/pages/calculadora/calculadora_moeda.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MoedaBlock extends StatelessWidget{
  String imageLocation = "assets/images/";
  CriptoMoeda ?dadosMoeda;

  MoedaBlock(this.dadosMoeda);

  NumberFormat formatter = NumberFormat("00.0000");

  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CalculadoraMoeda(moeda: dadosMoeda,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
        splashColor: Color.fromARGB(255, 12, 45, 71),
        onTap: (){
          Navigator.of(context).push(_createRoute()); 
        },
        child: Column(
          children: [
            Container(
              decoration: 
                BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 26.0)],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
                  color: Colors.white
                ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Column(
                        children: [
                          Text(dadosMoeda!.siglaMoeda!,style: TextStyle(fontSize: 40,fontWeight: FontWeight. bold, color: Colors.blue)),
                          Text(dadosMoeda!.nomeMoeda!,  style: TextStyle(fontSize: 20, color: Colors.blue))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: File(imageLocation+dadosMoeda!.nomeMoeda!+".png").existsSync() ? Image.asset(imageLocation+"default.png", width: 70,): Image.asset(imageLocation+dadosMoeda!.nomeMoeda!+".png", width: 70,),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text('Volume', style: TextStyle(fontSize: 16, fontWeight: FontWeight. bold, color: Colors.black54)),
                            Text(formatter.format(num.parse(dadosMoeda!.vol)).toString())
                          ],
                        ),
                        Column(
                          children: [
                            Text('Compra', style: TextStyle(fontSize: 16, fontWeight: FontWeight. bold, color: Colors.black54)),
                            Text(formatter.format(num.parse(dadosMoeda!.buy)).toString())
                            
                          ],
                        ),
                        Column(
                          children: [
                            Text('Venda', style: TextStyle(fontSize: 16, fontWeight: FontWeight. bold, color: Colors.black54)),
                            Text(formatter.format(num.parse(dadosMoeda!.sell)).toString())
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          ]
        )
      )
    );
  }

}