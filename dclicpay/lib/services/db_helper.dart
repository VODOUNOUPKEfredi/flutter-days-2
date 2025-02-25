import 'package:path/path.dart';

import 'package:dclicpay/models/user.dart';
import 'package:dclicpay/models/transaction.dart';

import 'package:sqflite/sqflite.dart' hide Transaction;


class DbHelper {
  
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE users (
      id $idType,
      email $textType,
      password $textType,
      balance $doubleType
    )
    ''');

    await db.execute('''
    CREATE TABLE transactions (
      id $idType,
      senderId INTEGER NOT NULL,
      receiverId INTEGER NOT NULL,
      amount $doubleType,
      date $textType,
      FOREIGN KEY (senderId) REFERENCES users (id),
      FOREIGN KEY (receiverId) REFERENCES users (id)
    )
    ''');
  }

  Future<int> createUser(User user) async {
    final db = await instance.database;
    final userWithDefaultBalance={
      'email':user.email,
      'password':user.password,
      'balance':1000.0,
    };
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      columns: ['id', 'email', 'password', 'balance'],
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateUserBalance(int userId, double newBalance) async {
    final db = await instance.database;
    return await db.update(
      'users',
      {'balance': newBalance},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> createTransaction(Transaction transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<Transaction>> getTransactionsByUserId(int userId) async {
    final db = await instance.database;
    final maps = await db.query(
      'transactions',
      where: 'senderId = ? OR receiverId = ?',
      whereArgs: [userId, userId],
      orderBy: 'date DESC',
    );

    return maps.map((map) => Transaction.fromMap(map)).toList();
  }
}
