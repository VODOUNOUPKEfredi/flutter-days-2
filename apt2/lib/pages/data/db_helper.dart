import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:apt2/pages/data/Authentification/user.dart'; // N'oublie pas d'importer ta classe User

class DbHelper {
  static Database? _database;

  // Initialiser la base de données SQLite
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialisation de la base de données
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_auth.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
      },
    );
  }

  // Inscrire un nouvel utilisateur
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Vérifier si l'utilisateur existe avec email et mot de passe
  Future<User?> getUserByEmailPassword(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null; // Utilisateur non trouvé
    }
  }

  getTransactions() {}
}