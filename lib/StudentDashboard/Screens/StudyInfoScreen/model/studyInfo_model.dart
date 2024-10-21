class StudyInfo {
  final String date;
  final String month;
  final String title;
  final String subject;
  final String room;
  final String time;
  final String seat;
  final String takeout;

  StudyInfo({
    required this.date,
    required this.month,
    required this.title,
    required this.subject,
    required this.room,
    required this.time,
    required this.seat,
    required this.takeout,
  });

  factory StudyInfo.fromJson(Map<String, dynamic> json) {
    return StudyInfo(
      date: json['date'] ?? '',
      month: json['month'] ?? '',
      title: json['title'] ?? '',
      subject: json['subject'] ?? '',
      room: json['room'] ?? '',
      time: json['time'] ?? '',
      seat: json['seat'] ?? '',
      takeout: json['takeout'] ?? '',
    );
  }
}
