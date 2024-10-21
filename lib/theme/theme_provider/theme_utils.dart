import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

bool isDarkMode(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return themeProvider.themeMode == ThemeMode.dark;
}
