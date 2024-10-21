import 'package:get/get.dart';

class PerformanceClass {
  final String yearNo;
  final List<Semester> semesters;

  PerformanceClass({
    required this.yearNo,
    required this.semesters,
  });

  factory PerformanceClass.fromJson(Map<String, dynamic> json) {
    return PerformanceClass(
      yearNo: json['year_no'] ?? '', // Provide a default value if null
      semesters: (json['semesters'] as Map<String, dynamic>)
          .values
          .map((e) => Semester.fromJson(e))
          .toList(),
    );
  }
}

class Semester {
  final String semesterNo;
  final String average;
  final String gpa;
  final String grade;
  final String meaning;
  final List<Subject> subjects;

  Semester({
    required this.semesterNo,
    required this.average,
    required this.gpa,
    required this.grade,
    required this.meaning,
    required this.subjects,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterNo: json['semester_no'] ?? '',
      average: json['average'] ?? '',
      gpa: json['gpa'] ?? '',
      grade: json['grade'] ?? '',
      meaning: json['meaning'] ?? '',
      subjects: (json['subjects'] as List)
          .map((subject) => Subject.fromJson(subject))
          .toList(),
    );
  }
}

class Subject {
  final String id;
  final String name;

  final String pscoreTotal;
  final String attendancePs; // Added attendance_ps field
  final List<Attendances> attendances;
  final List<Scores> scores;

  Subject({
    required this.id,
    required this.name,
    required this.pscoreTotal,
    required this.attendancePs,
    required this.attendances,
    required this.scores,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    // Get the current locale
    String languageCode = Get.locale?.languageCode ?? 'km';

    // Choose the appropriate name based on the language code
    String localizedName =
        languageCode == 'en' ? json['name_en'] : json['name_kh'];

    return Subject(
      id: json['id'] ?? '',
      name: localizedName,
      pscoreTotal: json['pscore_total'] ?? '0',
      attendancePs: json['attendance_ps'] ?? '0',
      attendances: (json['attendances'] as List)
          .map((attendance) => Attendances.fromJson(attendance))
          .toList(),
      scores: (json['scores'] as List)
          .map((score) => Scores.fromJson(score))
          .toList(),
    );
  }
}

class Attendances {
  final String title;
  final String attendanceA;
  final String attendancePm;
  final String attendanceAl;
  final String attendanceAll;
  final String attendancePs;

  Attendances({
    required this.title,
    required this.attendanceA,
    required this.attendancePm,
    required this.attendanceAl,
    required this.attendanceAll,
    required this.attendancePs,
  });

  factory Attendances.fromJson(Map<String, dynamic> json) {
    return Attendances(
      title: json['title'] ?? '',
      attendanceA: json['attendance_a'] ?? '0',
      attendancePm: json['attendance_pm'] ?? '0',
      attendanceAl: json['attendance_al'] ?? '0',
      attendanceAll: json['attendance_all'] ?? '0',
      attendancePs: json['attendance_ps'] ?? '0',
    );
  }
}

class Scores {
  final String title;
  final String scoreAttendance;
  final String scoreAssignment;
  final String scoreMidTerm;
  final String scoreFinal;
  final String numberAttendance;
  final String numberAssignment;
  final String numberMidTerm;
  final String numberFinal;

  Scores({
    required this.title,
    required this.scoreAttendance,
    required this.scoreAssignment,
    required this.scoreMidTerm,
    required this.scoreFinal,
    required this.numberAttendance,
    required this.numberAssignment,
    required this.numberMidTerm,
    required this.numberFinal,
  });

  factory Scores.fromJson(Map<String, dynamic> json) {
    return Scores(
      title: json['title'] ?? '',
      scoreAttendance: json['score_attendance'] ?? '0',
      scoreAssignment: json['score_assignment'] ?? '0',
      scoreMidTerm: json['score_mid_term'] ?? '0',
      scoreFinal: json['score_final'] ?? '0',
      numberAttendance: json['number_attendance'] ?? '0',
      numberAssignment: json['number_assignment'] ?? '0',
      numberMidTerm: json['number_mid_term'] ?? '0',
      numberFinal: json['number_final'] ?? '0',
    );
  }
}
