import 'bank.dart';

class WithDraw {
  final double amount;
  final Bank bank;
  final String accountNumber;

  WithDraw({
    required this.amount,
    required this.bank,
    required this.accountNumber,
  });

  toJson() {
    return {
      'amount': amount,
      'bank': bank.toJson(accountNumber),
    };
  }
}
