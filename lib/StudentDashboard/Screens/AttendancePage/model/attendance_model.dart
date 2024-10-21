// class Attendances {
//   final String yearNo;
//   final List<Semester> semesters;

//   Attendances({
//     required this.yearNo,
//     required this.semesters,
//   });

//   factory Attendances.fromJson(Map<String, dynamic> json) {
//     return Attendances(
//       yearNo: json['year_no'] ?? '',
//       semesters: (json['semesters'] as Map<String, dynamic>? ?? {})
//           .values
//           .map((e) => Semester.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class Semester {
//   final String semesterNo;
//   final List<Subject> subjects;

//   Semester({
//     required this.semesterNo,
//     required this.subjects,
//   });

//   factory Semester.fromJson(Map<String, dynamic> json) {
//     return Semester(
//       semesterNo: json['semester_no'] ?? '',
//       subjects: (json['subjects'] as List<dynamic>? ?? [])
//           .map((subject) => Subject.fromJson(subject))
//           .toList(),
//     );
//   }
// }

// class Subject {
//   final String id, code, nameKh, nameEn;
//   final int hour,
//       credit,
//       attendanceA,
//       attendancePm,
//       attendanceAl,
//       attendanceAll,
//       attendancePs;
//   final List<Dates> dates;

//   Subject({
//     required this.id,
//     required this.code,
//     required this.nameKh,
//     required this.nameEn,
//     required this.hour,
//     required this.credit,
//     required this.attendanceA,
//     required this.attendancePm,
//     required this.attendanceAl,
//     required this.attendanceAll,
//     required this.attendancePs,
//     required this.dates,
//   });

//   factory Subject.fromJson(Map<String, dynamic> json) {
//     return Subject(
//       id: json['id'] ?? '',
//       code: json['code'] ?? '',
//       nameKh: json['name_kh'] ?? '',
//       nameEn: json['name_en'] ?? '',
//       hour: _parseInt(json['hour']),
//       credit: _parseInt(json['credit']),
//       attendanceA: _parseInt(json['attendance_a']),
//       attendancePm: _parseInt(json['attendance_pm']),
//       attendanceAl: _parseInt(json['attendance_al']),
//       attendanceAll: _parseInt(json['attendance_all']),
//       attendancePs: _parseInt(json['attendance_ps']),
//       dates: (json['dates'] as List<dynamic>? ?? [])
//           .map((date) => Dates.fromJson(date))
//           .toList(),
//     );
//   }

//   static int _parseInt(dynamic value) {
//     if (value is String) {
//       return int.tryParse(value) ?? 0;
//     } else if (value is int) {
//       return value;
//     }
//     return 0;
//   }
// }

// class Dates {
//   final String dateName;
//   final List<Sessions> sessions;

//   Dates({
//     required this.dateName,
//     required this.sessions,
//   });

//   factory Dates.fromJson(Map<String, dynamic> json) {
//     return Dates(
//       dateName: json['date_name'] ?? '',
//       sessions: (json['sessions'] as List<dynamic>)
//           .map((session) => Sessions.fromJson(session))
//           .toList(),
//     );
//   }
// }

// class Sessions {
//   final String date, session, sessionAll, absentStatus;

//   Sessions({
//     required this.date,
//     required this.session,
//     required this.sessionAll,
//     required this.absentStatus,
//   });

//   factory Sessions.fromJson(Map<String, dynamic> json) {
//     return Sessions(
//       date: json['date'] ?? '',
//       session: json['session'] ?? '',
//       sessionAll: json['session_all'] ?? '',
//       absentStatus: json['absent_status'] ?? '',
//     );
//   }
// }

// update model with multi language
import 'package:get/get.dart';

class Attendances {
  final String yearNo;
  final List<Semester> semesters;

  Attendances({
    required this.yearNo,
    required this.semesters,
  });

  factory Attendances.fromJson(Map<String, dynamic> json) {
    return Attendances(
      yearNo: json['year_no'] ?? '',
      semesters: (json['semesters'] as Map<String, dynamic>? ?? {})
          .values
          .map((e) => Semester.fromJson(e))
          .toList(),
    );
  }
}

class Semester {
  final String semesterNo;
  final List<Subject> subjects;

  Semester({
    required this.semesterNo,
    required this.subjects,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterNo: json['semester_no'] ?? '',
      subjects: (json['subjects'] as List<dynamic>? ?? [])
          .map((subject) => Subject.fromJson(subject))
          .toList(),
    );
  }
}

class Subject {
  final String id;
  final String code;
  final String name; // Now a single field for the localized name
  final int hour;
  final int credit;
  final int attendanceA;
  final int attendancePm;
  final int attendanceAl;
  final int attendanceAll;
  final int attendancePs;
  final List<Dates> dates;

  Subject({
    required this.id,
    required this.code,
    required this.name, // Use localized name
    required this.hour,
    required this.credit,
    required this.attendanceA,
    required this.attendancePm,
    required this.attendanceAl,
    required this.attendanceAll,
    required this.attendancePs,
    required this.dates,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    // Get the current locale
    String languageCode = Get.locale?.languageCode ?? 'km';

    // Choose the appropriate name based on the language code
    String localizedName =
        languageCode == 'en' ? json['name_en'] : json['name_kh'];

    return Subject(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      name: localizedName, // Set the localized name
      hour: _parseInt(json['hour']),
      credit: _parseInt(json['credit']),
      attendanceA: _parseInt(json['attendance_a']),
      attendancePm: _parseInt(json['attendance_pm']),
      attendanceAl: _parseInt(json['attendance_al']),
      attendanceAll: _parseInt(json['attendance_all']),
      attendancePs: _parseInt(json['attendance_ps']),
      dates: (json['dates'] as List<dynamic>? ?? [])
          .map((date) => Dates.fromJson(date))
          .toList(),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is int) {
      return value;
    }
    return 0;
  }
}

class Dates {
  final String dateName;
  final List<Sessions> sessions;

  Dates({
    required this.dateName,
    required this.sessions,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      dateName: json['date_name'] ?? '',
      sessions: (json['sessions'] as List<dynamic>)
          .map((session) => Sessions.fromJson(session))
          .toList(),
    );
  }
}

class Sessions {
  final String date, session, sessionAll, absentStatus;

  Sessions({
    required this.date,
    required this.session,
    required this.sessionAll,
    required this.absentStatus,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) {
    return Sessions(
      date: json['date'] ?? '',
      session: json['session'] ?? '',
      sessionAll: json['session_all'] ?? '',
      absentStatus: json['absent_status'] ?? '',
    );
  }
}
