
import 'package:dclicpay/models/transaction.dart';
import 'package:dclicpay/models/user.dart';
import 'package:dclicpay/screens/transfer_page.dart';
import 'package:dclicpay/services/db_helper.dart';
import 'package:flutter/material.dart';


/// La page d'accueil qui affiche le solde de l'utilisateur et l'historique des transactions.
class HomePage extends StatefulWidget {
  final User user; // L'utilisateur actuellement connecté

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User currentUser; // Variable locale pour stocker l'utilisateur connecté
  List<Transaction> transactions = []; // Liste des transactions de l'utilisateur

  @override
  void initState() {
    super.initState();
    // Initialiser currentUser avec l'utilisateur passé en paramètre
    currentUser = widget.user;
    // Charger l'historique des transactions
    _loadTransactions();
  }

  /// Charge les transactions de l'utilisateur courant (envoyées ou reçues)
  Future<void> _loadTransactions() async {
    if (currentUser.id != null) {
      // Récupère toutes les transactions associées à l'utilisateur
      List<Transaction> fetchedTransactions =
          await DbHelper.instance.getTransactionsByUserId(currentUser.id!);
      setState(() {
        transactions = fetchedTransactions;
      });
    }
  }

  /// Navigue vers la page de transfert.
  /// Après le retour de la page de transfert, recharge les transactions mises à jour.
  void _navigateToTransferPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransferPage(currentUser: currentUser, user:User(
                  id: 0,
                  email: "invité@example.com",
                  password: "default",
                  balance: 10000.0,),),
        
      ),
    );
    // Recharger l'historique des transactions après un transfert
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      // Un RefreshIndicator permet de rafraîchir l'écran en tirant vers le bas
      body: RefreshIndicator(
        onRefresh: _loadTransactions,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Carte affichant le solde de l'utilisateur
              Card(
                margin: EdgeInsets.all(16.0),
                elevation: 4.0,
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, size: 40),
                  title: Text('Votre solde',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '${currentUser.balance.toStringAsFixed(2)} €',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              // Titre pour l'historique des transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Historique des transactions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Liste des transactions
              transactions.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Aucune transaction pour le moment.'),
                    )
                  : ListView.builder(
                      shrinkWrap: true, // Pour utiliser la liste dans une ScrollView
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        Transaction tx = transactions[index];
                        // Afficher un libellé différent selon que l'utilisateur soit l'expéditeur ou le destinataire
                        String label = (tx.senderId == currentUser.id)
                            ? 'Envoyé à l\'ID ${tx.receiverId}'
                            : 'Reçu de l\'ID ${tx.senderId}';
                        return Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          elevation: 2.0,
                          child: ListTile(
                            leading: Icon(
                              tx.senderId == currentUser.id
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: tx.senderId == currentUser.id
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            title: Text(label),
                            subtitle: Text(
                              'Montant: ${tx.amount.toStringAsFixed(2)} €\nDate: ${tx.date.toLocal().toString().split(' ')[0]}',
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      // Bouton flottant pour accéder à la page de transfert
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToTransferPage,
        tooltip: 'Transférer de l\'argent',
        child: Icon(Icons.send),
      ),
    );
  }
}