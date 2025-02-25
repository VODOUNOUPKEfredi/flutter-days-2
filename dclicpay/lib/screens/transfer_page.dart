import 'package:dclicpay/models/transaction.dart';
import 'package:dclicpay/models/user.dart';
import 'package:dclicpay/services/db_helper.dart';
import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  final User currentUser;

  TransferPage({required this.currentUser, required User user});

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _emailController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Méthode pour effectuer le transfert
  void _performTransfer() async {
    if (_formKey.currentState!.validate()) {
      String recipientEmail = _emailController.text;
      double amount = double.parse(_amountController.text);

      // Vérifier si le destinataire existe
      User? recipient = await DbHelper.instance.getUserByEmail(recipientEmail);
      if (recipient == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Destinataire introuvable')),
        );
        return;
      }

      // Vérifier si le solde est suffisant
      if (widget.currentUser.balance < amount) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Solde insuffisant')),
        );
        return;
      }

      // Mettre à jour les soldes
      setState(() {
        widget.currentUser.balance -= amount;
        recipient.balance += amount;
      });

      // Enregistrer les mises à jour dans la base de données
      await DbHelper.instance.updateUserBalance(widget.currentUser.id!, widget.currentUser.balance);
      await DbHelper.instance.updateUserBalance(recipient.id!, recipient.balance);

      // Créer et enregistrer la transaction
      Transaction transaction = Transaction(
        senderId: widget.currentUser.id!,
        receiverId: recipient.id!,
        amount: amount,
        date: DateTime.now(),
      );
      await DbHelper.instance.createTransaction(transaction);

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transfert réussi')),
      );

      // Réinitialiser les champs
      _emailController.clear();
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transférer de l\'argent')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email du destinataire'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'email du destinataire';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Montant à transférer'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _performTransfer,
                child: Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}