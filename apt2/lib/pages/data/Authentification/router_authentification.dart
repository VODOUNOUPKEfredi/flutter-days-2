import 'package:flutter/material.dart';
  // Ecran d'inscription
import 'package:apt2/pages/data/Authentification/registerScreen.dart'; 
import 'package:apt2/pages/data/Authentification/connexion.dart';  // Ecran de connexion

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentification SQLite',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/register',  // Lancer l'écran d'inscription
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}