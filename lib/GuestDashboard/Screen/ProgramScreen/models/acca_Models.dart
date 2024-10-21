class ProgramACCA {
  late String facultyName; // Use facultyName
  late List<Faculty_Data> facultyData; // Use facultyData

  ProgramACCA({
    required this.facultyName,
    required this.facultyData,
  });

  factory ProgramACCA.fromJson(Map<String, dynamic> json) {
    return ProgramACCA(
      facultyName: json['faculty_name'],
      facultyData: (json['faculty_data'] as List)
          .map((i) => Faculty_Data.fromJson(i))
          .toList(),
    );
  }
}

class Faculty_Data {
  late String fac_icon;
  late List<Major_Data> major_data;

  Faculty_Data({
    required this.fac_icon,
    required this.major_data,
  });

  factory Faculty_Data.fromJson(Map<String, dynamic> json) {
    return Faculty_Data(
      fac_icon: json['fac_icon'],
      major_data: (json['major_data'] as List)
          .map((i) => Major_Data.fromJson(i))
          .toList(),
    );
  }
}

class Major_Data {
  late String major_name;
  late String course_hour;
  late List<Subject_Data> subject_data;

  Major_Data({
    required this.major_name,
    required this.course_hour,
    required this.subject_data,
  });

  factory Major_Data.fromJson(Map<String, dynamic> json) {
    return Major_Data(
      major_name: json['major_name'],
      course_hour: json['course_hour'],
      subject_data: (json['subject_data'] as List)
          .map((i) => Subject_Data.fromJson(i))
          .toList(),
    );
  }
}

class Subject_Data {
  late String subject;
  late String hour_per_week;
  late String weeks;
  late String total_hour;

  Subject_Data({
    required this.subject,
    required this.hour_per_week,
    required this.weeks,
    required this.total_hour,
  });

  factory Subject_Data.fromJson(Map<String, dynamic> json) {
    return Subject_Data(
      subject: json['subject'],
      hour_per_week: json['hour_per_week'],
      weeks: json['weeks'],
      total_hour: json['total_hour'],
    );
  }
}
