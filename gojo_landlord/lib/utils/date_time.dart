import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String mmddyyy() {
    return DateFormat("MM/d/yyyy").format(this);
  }
}
