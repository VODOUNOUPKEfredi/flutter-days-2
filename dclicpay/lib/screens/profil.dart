import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;

  // Constructor pour recevoir les données de l'utilisateur
  ProfilePage({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Déconnexion ou redirection vers la page de connexion
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            Text('Nom: $userName', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Email: $userEmail', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redirection vers la page de changement de compte
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Changer de compte'),
            ),
          ],
        ),
      ),
    );
  }
}