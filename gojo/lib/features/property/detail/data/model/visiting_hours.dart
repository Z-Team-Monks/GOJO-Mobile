import 'package:intl/intl.dart';

class VisitingHours {
  final List<VisitingHourModel> visitingHours;

  VisitingHours({
    required this.visitingHours,
  });

  factory VisitingHours.fromJson(Map<String, dynamic> json) {
    return VisitingHours(
      visitingHours: (json['visiting_hours'] as List)
          .map((e) => VisitingHourModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<String> getTimesBetweenInterval(
    String startTime,
    String endTime,
  ) {
    DateTime startTimeDate = DateFormat('hh:mm a').parse(startTime);
    DateTime endTimeDate = DateFormat('hh:mm a').parse(endTime);

    List<String> times = [];

    while (startTimeDate.compareTo(endTimeDate) <= 0) {
      times.add(DateFormat('hh:mm a').format(startTimeDate.toLocal()));
      startTimeDate = startTimeDate.add(const Duration(hours: 1));
    }

    return times;
  }

  List<String> getTimesByDay(DateTime day) {
    for (var visitingHour in visitingHours) {
      if (visitingHour.day == getWeekday(day)) {
        return getTimesBetweenInterval(visitingHour.from, visitingHour.to);
      }
    }
    return [];
  }

  bool contains(DateTime dateTime) {
    for (var visitingHour in visitingHours) {
      if (visitingHour.day == getWeekday(dateTime)) {
        return true;
      }
    }
    return false;
  }

  static String getWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      default:
        return "Sunday";
    }
  }
}

class VisitingHourModel {
  final String from;
  final String to;
  final String day;

  VisitingHourModel({
    required this.from,
    required this.to,
    required this.day,
  });

  factory VisitingHourModel.fromJson(Map<String, dynamic> json) {
    return VisitingHourModel(
      from: json['from'] as String,
      to: json['to'] as String,
      day: json['day'] as String,
    );
  }
}
