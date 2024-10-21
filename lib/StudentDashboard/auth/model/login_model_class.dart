/* 

  Define login class

*/

class StudentUsers {
  final String nameKh;
  final String studentId;
  final String pwd;
  final String guardianId;

  StudentUsers({
    required this.nameKh,
    required this.studentId,
    required this.pwd,
    required this.guardianId,
  });

  // Convert JSON to StudentUsers
  factory StudentUsers.fromJson(Map<String, dynamic> json) {
    return StudentUsers(
      nameKh: json['name_kh'],
      studentId: json['student_id'],
      pwd: json['pwd'],
      guardianId: json['guardian_id'],
    );
  }

  // Convert StudentUsers to JSON
  Map<String, dynamic> toJson() {
    return {
      'name_kh': nameKh,
      'student_id': studentId,
      'pwd': pwd,
      'guardian_id': guardianId,
    };
  }
}

class JobHistoryData {
  final String dateStartWork;
  final String statusName;
  final String workPlace;
  final String position;
  final String salary;

  JobHistoryData({
    required this.dateStartWork,
    required this.statusName,
    required this.workPlace,
    required this.position,
    required this.salary,
  });

  factory JobHistoryData.fromJson(Map<String, dynamic> json) {
    return JobHistoryData(
      dateStartWork: json['date_start_work'],
      statusName: json['status_name'],
      workPlace: json['work_place'],
      position: json['position'],
      salary: json['salary'],
    );
  }
}

class UserData {
  final String academicYear;
  final String facultyName;
  final String degreeName;
  final String majorName;
  final String yearName;
  final String semesterName;
  final String nameKh;
  final String nameEn;
  final String studentId;
  final String stageName;
  final String termName;
  final String shiftName;
  final String roomName;
  final String statusName;
  final String dateOfBirth;
  final String phoneNumber;
  final String profilePic;
  final String job;
  final String workPlace;

  UserData({
    required this.academicYear,
    required this.facultyName,
    required this.degreeName,
    required this.majorName,
    required this.yearName,
    required this.semesterName,
    required this.nameKh,
    required this.nameEn,
    required this.studentId,
    required this.stageName,
    required this.termName,
    required this.shiftName,
    required this.roomName,
    required this.statusName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.profilePic,
    required this.job,
    required this.workPlace,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      academicYear: json['academic_year'],
      facultyName: json['faculty_name'],
      degreeName: json['degree_name'],
      majorName: json['major_name'],
      yearName: json['year_name'],
      semesterName: json['semester_name'],
      nameKh: json['name_kh'],
      nameEn: json['name_en'],
      studentId: json['student_id'],
      stageName: json['stage_name'],
      termName: json['term_name'],
      shiftName: json['shift_name'],
      roomName: json['room_name'],
      statusName: json['status_name'],
      dateOfBirth: json['date_of_birth'],
      phoneNumber: json['phone_number'],
      profilePic: json['profile_pic'],
      job: json['job'],
      workPlace: json['work_place'],
    );
  }

  // Convert UserData to JSON
  Map<String, dynamic> toJson() {
    return {
      'academic_year': academicYear,
      'faculty_name': facultyName,
      'degree_name': degreeName,
      'major_name': majorName,
      'year_name': yearName,
      'semester_name': semesterName,
      'name_kh': nameKh,
      'name_en': nameEn,
      'student_id': studentId,
      'stage_name': stageName,
      'term_name': termName,
      'shift_name': shiftName,
      'room_name': roomName,
      'status_name': statusName,
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
      'profile_pic': profilePic,
      'job': job,
      'work_place': workPlace,
    };
  }
}

class SurveyStatus {
  SurveyStatus();

  factory SurveyStatus.fromJson(Map<String, dynamic> json) {
    return SurveyStatus();
  }
}

class UserDataResponse {
  final List<StudentUsers> studentUsers;
  final List<SurveyStatus> surveyStatus;
  final List<JobHistoryData> jobHistoryData;
  final List<UserData> userData;

  UserDataResponse({
    required this.studentUsers,
    required this.surveyStatus,
    required this.jobHistoryData,
    required this.userData,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      studentUsers: (json['student_users'] as List)
          .map((item) => StudentUsers.fromJson(item))
          .toList(),
      surveyStatus: (json['survey_status'] as List)
          .map((item) => SurveyStatus.fromJson(item))
          .toList(),
      jobHistoryData: (json['job_history_data'] as List)
          .map((item) => JobHistoryData.fromJson(item))
          .toList(),
      userData: (json['user_data'] as List)
          .map((item) => UserData.fromJson(item))
          .toList(),
    );
  }
}
