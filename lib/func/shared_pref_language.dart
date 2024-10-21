import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelperLanguage {
  static const String languageKey = 'selectedLanguage';

  // Save selected language
  static Future<void> setLanguageCode(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, languageCode);
  }

  // Load selected language
  static Future<String?> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey);
  }
}
