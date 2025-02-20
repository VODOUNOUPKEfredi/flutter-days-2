import 'package:flutter/material.dart';
import 'package:apt2/pages/data/db_helper.dart';
import 'user.dart';  // Import de la classe User

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final DbHelper dbHelper = DbHelper();
  String _errorMessage = '';

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      User? user = await dbHelper.getUserByEmailPassword(email, password);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Connexion réussie')));
        // Rediriger vers l'écran principal
      } else {
        setState(() {
          _errorMessage = 'Email ou mot de passe incorrect';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Tous les champs sont obligatoires';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
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
              onPressed: _login,
              child: Text('Se connecter'),
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