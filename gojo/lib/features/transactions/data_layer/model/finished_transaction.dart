class FinishedTransaction {
  final String id;
  final String title;
  final int payedAmount;
  final String thumbnailUrl;
  final String paymentDate;

  FinishedTransaction({
    required this.id,
    required this.title,
    required this.payedAmount,
    required this.thumbnailUrl,
    required this.paymentDate,
  });

  factory FinishedTransaction.fromJson(Map<String, dynamic> json) {
    return FinishedTransaction(
      id: json['id'],
      title: json['title'],
      payedAmount: json['payedAmount'],
      thumbnailUrl: json['thumbnailUrl'],
      paymentDate: json['paymentDate'],
    );
  }
}
