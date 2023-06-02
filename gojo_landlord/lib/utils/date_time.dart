import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String mmddyyy() {
    return DateFormat("MM/d/yyyy").format(this);
  }
}

class HourFormats {
  static String to12Hour(int hour) {
    if (hour == 0) {
      return "12 AM";
    } else if (hour < 12) {
      return "$hour AM";
    } else if (hour == 12) {
      return "12 PM";
    } else {
      return "${hour - 12} PM";
    }
  }
}
