import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  double totalBalance = 10000.00;

  List<Transaction> transactions = [
    Transaction(
        name: "Miradie",
        amount: 1190.00,
        date: DateTime(2025, 1, 22),
        avatar: "assets/miradie.png"),
    Transaction(
        name: "Emeric",
        amount: -75.00,
        date: DateTime(2025, 1, 21),
        avatar: "assets/emeric.png"),
    Transaction(
        name: "Nelly",
        amount: -220.00,
        date: DateTime(2025, 1, 20),
        avatar: "assets/nelly.png"),
    Transaction(
        name: "Silas",
        amount: 2000.00,
        date: DateTime(2025, 1, 19),
        avatar: "assets/silas.png"),
    Transaction(
        name: "Fanny",
        amount: 3000.00,
        date: DateTime(2025, 1, 19),
        avatar: "assets/silas.png"),
    Transaction(
        name: "Fredi",
        amount: 2500.00,
        date: DateTime(2025, 1, 19),
        avatar: "assets/silas.png"),
    Transaction(
        name: "Richard",
        amount: 900.00,
        date: DateTime(2025, 1, 19),
        avatar: "assets/silas.png"),
    Transaction(
        name: "Honorine",
        amount: 100.00,
        date: DateTime(2025, 1, 19),
        avatar: "assets/silas.png"),
  ];

  void addTransaction(Transaction transaction) {
    transactions.insert(0, transaction);
    totalBalance += transaction.amount;
    notifyListeners();
  }

  void filterTransactions(String selectedFilter) {}
}