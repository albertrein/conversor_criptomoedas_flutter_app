import 'package:conversor_criptomoedas/helper/theme/theme_helper.dart';
import 'package:conversor_criptomoedas/models/theme_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path/path.dart';


class TemaConfigPage extends StatelessWidget{
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  ThemeConfigData dadosConfiguracaoTema;
  ThemeConfig configTema = ThemeConfig();

  TemaConfigPage(this.dadosConfiguracaoTema);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração do Tema'),
        backgroundColor: dadosConfiguracaoTema.getBackgroundAppBarColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: OutlinedButton(
                onPressed: () async {
                  currentColor = Color(await ThemeConfig.getAppBarBackgroundColor);
                  _showMaterialDialog(context, ConfigItens.setAppBarBackgroundColor);
                },
                child: const Text('Alterar cor de fundo da app bar'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  minimumSize: Size(50, 30),
                  textStyle: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
            ),
            Container(
              child: OutlinedButton(
                onPressed: () async {
                  currentColor = Color(await ThemeConfig.getBodyBackgroundColor);
                  _showMaterialDialog(context, ConfigItens.setBodyBackgroundColor);
                },
                child: const Text('Alterar cor de fundo do corpo'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  minimumSize: Size(50, 30),
                  textStyle: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
              
            ),
          ],
        ),
      )      
    );
  }

  Widget _dialogBuilder(){
    return ColorPicker(
      pickerColor: currentColor,
      onColorChanged: (color) {
        pickerColor = color;
      },
    );
  }
  void _showMaterialDialog(context, enumConfigThemeType) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Escolha a nova cor'),
            actions: <Widget>[
              _dialogBuilder(),
              TextButton(
                onPressed: () {
                  pickerColor = Color(0xff443a49);
                  currentColor = Color(0xff443a49);
                  Navigator.pop(context);
                },
                child: const Text('Fechar')),
              TextButton(
                onPressed: () async {                  
                  configTema.setNewColor(enumConfigThemeType, pickerColor.value);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              )
            ],
          );
        });
  }

}