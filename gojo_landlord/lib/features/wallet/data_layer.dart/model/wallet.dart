import 'balance.dart';
import 'transaction.dart';

class Wallet {
  final Balance balance;
  final List<Transaction> transactions;

  const Wallet({
    required this.balance,
    required this.transactions,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: Balance.fromJson(json['balance']),
      transactions: json['transactions']
          .map<Transaction>((transaction) => Transaction.fromJson(transaction))
          .toList(),
    );
  }
}
