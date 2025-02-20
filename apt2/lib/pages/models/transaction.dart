class Transaction {
  int ? id;
  String sender;
  int amount;
  String date;

  Transaction({
    this.id,required this.sender,
    required this.date,
    required this.amount,
  });

 //convertir en Map pour SqLite
 Map<String,dynamic> toMap(){
  return{
    'id':id,
    'sender':sender,
    'date':date,
    'amount':amount,
  };
 }

 //convertir un map sqlite en objet
 factory Transaction.fromMap(Map<String,dynamic> map){
  return Transaction(
    id: map['id'],
    sender: map['sender'], 
    date: map['date'], 
    amount:map['amount'],
    );
 }
}