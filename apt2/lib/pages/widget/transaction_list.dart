import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apt2/pages/provider/transaction_provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: provider.transactions.length,
      itemBuilder: (context, index) {
        final transaction = provider.transactions[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(transaction.avatar),
          ),
          title: Text(transaction.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${transaction.date.day} ${_monthName(transaction.date.month)} ${transaction.date.year} - 22h42"),
          trailing: Text(
            "${transaction.amount > 0 ? '+' : '-'} \$${transaction.amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              color: transaction.amount > 0 ? Colors.blue : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  String _monthName(int month) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[month - 1];
  }
}
