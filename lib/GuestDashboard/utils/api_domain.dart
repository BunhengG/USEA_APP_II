// lib/config/api_config.dart
class ApiConfig {
  static const String _baseUrl = 'https://usea.edu.kh';

  static String getEventDataUrl(String languageCode) {
    return '$_baseUrl/api/webapi.php?action=events_${languageCode == 'km' ? 'kh' : 'en'}';
  }

  static String getRegistrationDataUrl() {
    return '$_baseUrl/api/webapi.php?action=registration_info';
  }

  static String getStudyProgramUrl(String languageCode) {
    return '$_baseUrl/api/webapi.php?action=study_program_${languageCode == 'km' ? 'kh' : 'en'}';
  }

  static String getAccaUrl(String languageCode) {
    return '$_baseUrl/api/webapi.php?action=acca_${languageCode == 'km' ? 'kh' : 'en'}';
  }

  static String getCareerCenterUrl(String languageCode) {
    return '$_baseUrl/api/webapi.php?action=career_${languageCode == 'km' ? 'kh' : 'en'}';
  }

  static String getVideosDataUrl() {
    return '$_baseUrl/api/webapi.php?action=yt_video';
  }

  static String getAboutUsDataUrl(String languageCode) {
    return '$_baseUrl/api/webapi.php?action=recognition_${languageCode == 'km' ? 'kh' : 'en'}';
  }
  static String getFQADataUrl(String languageCode) {
  return '$_baseUrl/api/webapi.php?action=faq${languageCode == 'km' ? '' : '_en'}';
}

}
