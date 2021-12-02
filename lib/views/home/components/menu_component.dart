import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
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
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Moedas disponíveis'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.class__outlined),
            title: const Text('Sobre'),
            onTap: () => {},
          ),          
        ],
      ),
    );
  }
}