/*

  Define Schedule Class

 */

class ScheduleItem {
  final String datefull;
  final String date;
  final String month;
  final String wday;
  final String weekday;
  final String session;
  final String subject;
  final String teacherName;
  final String tel;
  final String classroom;

  ScheduleItem({
    required this.datefull,
    required this.date,
    required this.month,
    required this.wday,
    required this.weekday,
    required this.session,
    required this.subject,
    required this.teacherName,
    required this.tel,
    required this.classroom,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      datefull: json['datefull'],
      date: json['date'],
      month: json['month'],
      wday: json['wday'],
      weekday: json['weekday'],
      session: json['session'],
      subject: json['subject'],
      teacherName: json['teacherName'],
      tel: json['tel'],
      classroom: json['classroom'],
    );
  }
}
