import 'package:flutter/material.dart';
import '../db_helper.dart';  // Import du helper de la base de données
import 'package:apt2/pages/data/Authentification/registerScreen.dart';  // Import de la classe User
import 'package:apt2/pages/data/Authentification/user.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final DbHelper dbHelper = DbHelper();
  String _errorMessage = '';

  Future<void> _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      User newUser = User(email: email, password: password);
      await dbHelper.insertUser(newUser);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inscription réussie')));
      Navigator.pushReplacementNamed(context, '/login'); // Redirige vers la page de connexion
    } else {
      setState(() {
        _errorMessage = 'Tous les champs sont obligatoires';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('S\'inscrire'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}