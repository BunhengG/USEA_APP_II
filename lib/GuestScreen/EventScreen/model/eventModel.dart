class Event {
  final String title;
  final String description;
  final String image;
  final String eventDate;
  final String time;

  Event({
    required this.title,
    required this.description,
    required this.image,
    required this.eventDate,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      eventDate: json['event_date'],
      time: json['time'],
    );
  }
}
