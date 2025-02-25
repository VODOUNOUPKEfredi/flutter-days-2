import 'package:flutter/material.dart';
import 'package:dclicpay/screens/home_page.dart';
import 'package:dclicpay/screens/profil.dart';
import 'package:dclicpay/screens/transfer_page.dart';
import 'package:dclicpay/screens/wallet.dart';
import 'package:dclicpay/screens/login_page.dart';
import 'package:dclicpay/models/user.dart';  // Import de la classe User

import 'package:sqflite_common_ffi/sqflite_ffi.dart';  // Pour Windows/Mac/Linux
import 'dart:io';  // Pour détecter la plateforme

void main() {
  // Initialisation spécifique pour Windows, Mac et Linux
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    sqfliteFfiInit();  // Initialisation de la base de données
    databaseFactory = databaseFactoryFfi;  // Configuration de databaseFactory
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      home: MainScreen(), // La page principale avec la BottomNavigationBar
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Simulation d'un utilisateur connecté
  final User currentUser = User(id: 1, email: 'email@example.com', password: '');

  // Liste des pages correspondant aux onglets
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(user: currentUser),  // Écran d'accueil
      ProfilePage(userName: currentUser.email, userEmail: currentUser.email), // Profil
      WalletPage(), // Portefeuille
      TransferPage(currentUser: currentUser, user: User(id: 1, email: 'email@example.com', password: '',), // Envoi d'argent
    )];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Change l'index de la page affichée
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Affiche la page correspondante
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Couleur de l'élément sélectionné
        unselectedItemColor: Colors.grey, // Couleur des éléments non sélectionnés
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Envoyer',
          ),
        ],
      ),
    );
  }
}