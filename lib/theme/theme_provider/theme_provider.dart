import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadTheme(); // Load the theme preference when the provider is initialized.
  }

  ThemeMode get themeMode => _themeMode; // Getter for the current theme mode.

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get the shared preferences instance.
    String? theme =
        prefs.getString('theme'); // Retrieve the saved theme preference.
    if (theme != null) {
      // Set the theme mode based on the saved preference.
      _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners(); // Notify listeners about the theme change.
  }

  Future<void> toggleTheme() async {
    // Toggle between dark and light mode.
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get the shared preferences instance.
    // Save the new theme preference.
    await prefs.setString(
        'theme', _themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners(); // Notify listeners about the theme change.
  }

  //* Add this method to reset theme to light after logout
  Future<void> resetTheme() async {
    _themeMode = ThemeMode.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('theme'); // Remove theme preference
    notifyListeners(); // Notify listeners about the theme change.
  }
}
