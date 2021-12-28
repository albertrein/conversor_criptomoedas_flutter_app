import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path/path.dart';

class TemaConfig extends StatelessWidget{
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Reminder'),
      ),
      body: 
        Container(
          child: OutlinedButton(
          onPressed: () {
            _showMaterialDialog(context);
          },
          child: const Text('Open Dialog'),
        ),
      )
    );
  }

  Widget _dialogBuilder(){
    return ColorPicker(
      pickerColor: pickerColor,
      onColorChanged: (color) {
          //recebe a cor selecionada
      },
    );
  }
  void _showMaterialDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Material Dialog'),
            content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              _dialogBuilder(),
              TextButton(
                  onPressed: () {
                   
                  },
                  child: Text('Close')),
              TextButton(
                onPressed: () {
                  print('HelloWorld!');
                  
                },
                child: Text('HelloWorld!'),
              )
            ],
          );
        });
  }

}