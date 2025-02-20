import 'package:apt2/pages/data/db_helper.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart' as sqflite;
//import 'package:apt2/pages/data/db_helper.dart';
import 'package:apt2/pages/models/transactions.dart';
//import 'package:sqflite/sqlite_api.dart';


class TransactionList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final DbHelper dbHelper = DbHelper();
  List<Transactions> transactions=[];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }
  //methode pour charger les transactions
  void _loadTransactions() async {
    transactions = (await dbHelper.getTransactions()).cast<Transactions>();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context ,index){

          final transaction= transactions[index];
          return
           ListTile(
            title: Text(transaction.sender),
            subtitle:  Text("Montant:${transactions.amount}"),
            trailing: Text(transaction.date),
           );
        }
        
        
        )
    );
  }
}

extension on List<Transactions> {
  get amount => null;
}