import 'package:dartz/dartz.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/utils/string.dart';
import 'package:intl/intl.dart';

class Transaction {
  final int id;
  final String title;
  final String amount;
  final String date;
  final String time;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.time,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    // DateTime.now().toIso8601String()
    final dateTime = _getFormattedDate(json['payment_date']);
    final status = json['status'].toString().capitalize();
    return Transaction(
      id: json['id'],
      title: status,
      amount: json['amount'],
      date: dateTime.value1,
      time: dateTime.value2,
      type: _getTypeFromString(status),
    );
  }

  static TransactionType _getTypeFromString(String status) {
    switch (status) {
      case "Pending":
        return TransactionType.pending;
      case "Withdrawal approved":
        return TransactionType.approved;
      case "Withdrawal denied":
        return TransactionType.denied;
      default:
        return TransactionType.payed;
    }
  }

  static Tuple2<String, String> _getFormattedDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    // Extracting the date
    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    // Extracting the hour
    String hour =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return Tuple2(date, hour);
  }
}

enum TransactionType {
  pending,
  approved,
  denied,
  payed,
}
