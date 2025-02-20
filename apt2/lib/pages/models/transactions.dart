class Transactions {
  int? id;
  String sender;
  String? recipient;
  double amount;
  String date;

  Transactions({
    this.id,
    required this.sender,
    required this.date,
    this.recipient,
    required this.amount,
  });

  //convertir en Map pour SqLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'recipient': recipient,
      'date': date,
      'amount': amount,
    };
  }

  //convertir un map sqlite en objet
  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: map['id'],
      sender: map['sender'],
      recipient: map['recipient'],
      date: map['date'],
      amount: (map['amount'] as num).toDouble(),
    );
  }
}
