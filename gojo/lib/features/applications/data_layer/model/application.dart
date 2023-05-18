class Application {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String applicationDate;
  final String startDate;
  final String endDate;
  final String description;

  Application({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.applicationDate,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  Application.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumbnailUrl = json['thumbnailUrl'],
        applicationDate = json['applicationDate'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        description = json['description'];
}
