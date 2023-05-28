class FinishedTransaction {
  final int id;
  final String title;
  final String payedAmount;
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
      title: json['property_title'],
      payedAmount: json['amount'],
      thumbnailUrl: json['property_image'],
      paymentDate: json['payment_date'],
    );
  }
}
