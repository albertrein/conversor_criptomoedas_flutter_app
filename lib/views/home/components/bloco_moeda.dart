import 'package:conversor_criptomoedas/models/criptomoeda_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MoedaBlock extends StatelessWidget{
  String imageLocation = "";
  CriptoMoeda ?dadosMoeda;

  MoedaBlock(this.imageLocation, this.dadosMoeda);

 NumberFormat formatter = NumberFormat("00.0000");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
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
                          Text('BTC',style: TextStyle(fontSize: 40,fontWeight: FontWeight. bold, color: Colors.blue)),
                          Text('Bitcoin',  style: TextStyle(fontSize: 20, color: Colors.blue))
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 20), child: Image.asset(imageLocation, width: 70,),)
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