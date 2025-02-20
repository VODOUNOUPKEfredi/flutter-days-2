class User {
  int? id;
  String email;
  String password;

  User({this.id, required this.email, required this.password});

  // Convertir l'objet User en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  // Convertir un Map SQLite en objet User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}