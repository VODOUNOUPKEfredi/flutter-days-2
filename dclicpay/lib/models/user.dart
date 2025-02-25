class User {
  final int? id;
  final String email;
  final String password;
  double balance;

  User({
    this.id,
    required this.email,
    required this.password,
    this.balance = 10000.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'balance': balance,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      balance: map['balance'],
    );
  }
}