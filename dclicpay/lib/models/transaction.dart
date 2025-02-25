class Transaction {
  final int? id;
  final int senderId;
  final int receiverId;
  final double amount;
  final DateTime date;

  Transaction({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}