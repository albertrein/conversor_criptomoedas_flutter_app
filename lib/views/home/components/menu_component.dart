import 'package:conversor_criptomoedas/models/theme_config_model.dart';
import 'package:conversor_criptomoedas/views/pages/ajustes_tema/tema_config.dart';
import 'package:conversor_criptomoedas/views/pages/moedas_persistencia/moedas_persistencia_page.dart';
import 'package:flutter/material.dart';

import '../../pages/sobre/sobre.dart';

class Menu extends StatelessWidget {
  final ThemeConfigData dadosConfiguracaoTema;

  Menu(this.dadosConfiguracaoTema);

  @override
  Widget build(BuildContext context) {
    return Drawer(      
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100.0,
            child: const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.black87,                  
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.align_vertical_center_sharp),
            title: const Text('Ajustes tema'),
            onTap: () async => {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => TemaConfigPage(dadosConfiguracaoTema)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Moedas disponíveis'),
            onTap: () async => {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => MoedasPersistencia(dadosConfiguracaoTema)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.class__outlined),
            title: const Text('Sobre'),
            onTap: ()async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => Sobre(dadosConfiguracaoTema)));  
            },
          ),          
        ],
      ),
    );
  }
}