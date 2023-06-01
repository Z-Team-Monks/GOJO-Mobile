class Balance {
  final double amount;

  const Balance({
    required this.amount,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}
