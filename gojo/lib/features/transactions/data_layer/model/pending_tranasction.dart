class PendingTrasaction {
  final int id;
  final String title;
  final String amount;
  final String dueDate;
  final String thumbnailUrl;

  PendingTrasaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.thumbnailUrl,
  });

  factory PendingTrasaction.fromJson(Map<String, dynamic> json) {
    return PendingTrasaction(
      id: json['id'],
      title: json['property_title'],
      amount: json['amount'],
      dueDate: json['payment_date'],
      thumbnailUrl: json['property_image'],
    );
  }
}
