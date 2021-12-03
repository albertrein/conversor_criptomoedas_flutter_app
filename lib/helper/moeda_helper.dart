import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import '../models/moeda_model.dart';

class DatabaseHelper {
  String moedaTable = 'tbmoedas';
  String colSigla = 'sigla';
  String colNome = 'nome';
  String colSequencia = 'sequencia';

  DatabaseHelper();
  DatabaseHelper._createInstancia();

  DatabaseHelper.ensureInitialized();

  static final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(
      join(path, 'biblioteca_database.db'),
      onCreate: (db, version) {
        db.execute(
          'Create table tbmoedas('
          'sigla TEXT PRIMARY KEY,'
          'nome TEXT,'
          'sequencia INTEGER)'
        );
        db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('BTC', 'Bitcoin') ");
        db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('ETH', 'Etherium') ");
        db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('ETI', 'DOges') ");
        db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('LTC', 'Litecoin') ");
        db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('ADA', 'Cardano') ");
        db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('UNI', 'Uniswap') ");
        return db.execute("INSERT INTO tbmoedas(sigla, nome, sequencia) VALUES ('USDC', 'USD Coin') ");
      },
      version: 1,
    );
  });

  Future<int> insereMoeda(Moeda moeda) async {
    final db = await database;
    print(">>");
    print(moeda.toMap());
    return await db.insert(
      moedaTable,
      moeda.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  void droptable() async {
     final db = await database;
    await db.execute("DROP TABLE IF EXISTS moedas_table");

  }

  Future <List<Moeda>> listaDeTodosAsMoedas() async {
    final db = await database;

    var maps = await db.query(moedaTable);
    int count = maps.length;
    List<Moeda> moedas = [];
    for(int i=0;i<count; i++){
      moedas.add(Moeda.fromMapObject(maps[i]));
    }
    return moedas;
  }

  Future <List<Moeda>> moedasOrdenadasPorSequencia() async {
    final db = await database;

    var maps = await db.rawQuery("SELECT * FROM $moedaTable ORDER BY sequencia");
    int count = maps.length;
    List<Moeda> moedas = [];
    for(int i=0;i<count; i++){
      moedas.add(Moeda.fromMapObject(maps[i]));
    }
    return moedas;
  }

  Future<int> alteraSequenciaMoedas(Moeda moeda, int sequenciaNova) async {
    final db = await database;
    return await db.rawUpdate("UPDATE ${moedaTable} SET ${colSequencia} = ${sequenciaNova} WHERE ${colSigla} LIKE '${moeda.sigla}'");
  }

  Future<int> excluiMoeda(String siglaExclusao) async{
    final db = await database;
    int result = await db.rawDelete("DELETE FROM $moedaTable WHERE $colSigla LIKE '$siglaExclusao'");
    return result;
  }
  
  Future<int> ultimaSequenciaCadastrada() async{
    final db = await database;
    var response = await db.rawQuery("SELECT MAX(${colSequencia}) as seq FROM $moedaTable");
    int maiorValor = 0;
    response.forEach((element) {
      maiorValor = int.parse(element['seq'].toString());
    });
    return maiorValor;
  }

}