import 'package:get/get.dart';

class ApiEndpoints {
  // Define both Khmer and English base URLs
  static const String _baseKHUrl =
      'http://116.212.155.149:9999/api/apidata.php?';
  static const String _baseENUrl =
      'http://116.212.155.149:9999/api/apidata_en.php?';

  // Method to get the base URL based on the current locale or language code
  static String get _baseUrl {
    String languageCode =
        Get.locale?.languageCode ?? 'km'; // Default to 'km' (Khmer)
    return languageCode == 'en' ? _baseENUrl : _baseKHUrl;
  }

  // API Endpoints with dynamic base URL based on language code
  static String get loginUserData => '${_baseUrl}action=login_student';
  static String get creditData => '${_baseUrl}action=study_credit';
  static String get scheduleData => '${_baseUrl}action=study_schedule';
  static String get performanceData => '${_baseUrl}action=study_performance';
  static String get attendanceData => '${_baseUrl}action=attendance_data';
  static String get paymentData => '${_baseUrl}action=payment';
  static String get paymentOtherData => '${_baseUrl}action=other_payment';
  static String get jobHistoryData => '${_baseUrl}action=login_student';
  static String get studyInfoData => '${_baseUrl}action=exam_schedule';
  static String get feedbackData => '${_baseUrl}action=feedback';
}
