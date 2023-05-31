class Transaction {
  final String id;
  final String title;
  final double amount;
  final String date;
  final String type;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: json['date'],
      type: json['status'],
    );
  }
}
