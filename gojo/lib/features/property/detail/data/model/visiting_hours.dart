import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitingHours {
  final List<VisitingHourModel> visitingHours;

  VisitingHours({
    required this.visitingHours,
  });

  factory VisitingHours.fromJson(dynamic json) {
    debugPrint(json.toString());
    return VisitingHours(
      visitingHours: (json as List)
          .map(
            (e) => VisitingHourModel.fromJson(e),
          )
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

  List<String> getTimesByDay(DateTime? day) {
    if (day == null) return [];

    for (var visitingHour in visitingHours) {
      if (visitingHour.day == DateFormat('EEEE').format(day)) {
        return getTimesBetweenInterval(visitingHour.from, visitingHour.to);
      }
    }
    return [];
  }

  bool contains(DateTime dateTime) {
    for (var visitingHour in visitingHours) {
      if (visitingHour.day == DateFormat('EEEE').format(dateTime)) {
        return true;
      }
    }
    return false;
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
