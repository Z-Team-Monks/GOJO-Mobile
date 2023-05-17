class PendingTrasaction {
  final String id;
  final String title;
  final int amount;
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
      title: json['title'],
      amount: json['amount'],
      dueDate: json['dueDate'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
