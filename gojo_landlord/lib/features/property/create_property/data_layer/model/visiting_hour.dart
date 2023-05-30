class VisitingHour {
  final String day;
  final int from;
  final int to;

  VisitingHour({
    required this.day,
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'from': from,
      'to': to,
    };
  }
}

class WeeklyVisitingHours {
  Map<String, VisitingHour> map = {};

  WeeklyVisitingHours();

  Map<String, dynamic> toJson() {
    return {
      'visiting_hours': map.values.map((e) => e.toJson()).toList(),
    };
  }

  void addVisitingHour(VisitingHour visitingHour) {
    map[visitingHour.day] = visitingHour;
  }

  void removeVisitingHour(String day) {
    map.remove(day);
  }

  VisitingHour? getVisitingHour(String day) {
    return map[day];
  }
}
