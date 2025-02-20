import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DbHelper {
  static Database? _database;
  // recuperation des donnees
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _iniDatabase();

    return _database!;
  }

  //Initialiser la base de donnees
  Future<Database> _iniDatabase() async {
    String path = join(await getDatabasesPath(), 'transaction.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE transaction(
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   amount INTEGER,
   recipient TEXT,
   date TEXT
   )""");
      },
    );
  }
}
//ajouter une transaction 
Future <void> insertTransaction (int amount , String recipient) async{
final db = await database;
String currentDate =DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
await db.insert("transaction",{
  "amount":amount,
  "recipient": recipient,
  "date":currentDate,
});
}
//recuperer toutes transactions
Future<List<Map<String,dynamic>>> getTransaction() async{
final db  = await database;
return await db.query("transactions",orderBy:"date DESC");// trie par date(la plus recent)
}
