class UserWithBalance {
  final String userId;
  final String userName;
  double balance;

  UserWithBalance({
    required this.userId,
    required this.userName,
    this.balance = 0.0,
  });

  // Tu peux ajouter des méthodes ici pour manipuler les données, par exemple pour modifier le solde
}