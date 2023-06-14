class Application {
  final int id;
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
        title = json['tenant']['name'],
        thumbnailUrl = json['tenant']['picture'],
        applicationDate = json['application_date'],
        startDate = json['possible_start_date'],
        endDate = json['possible_end_date'],
        description = json['description'];
}
