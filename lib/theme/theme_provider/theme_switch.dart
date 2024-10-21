import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: () async {
        await themeProvider.toggleTheme();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 60,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: isDarkMode ? Colors.green : Colors.blueGrey.shade300,
        ),
        child: Stack(
          children: [
            // Switch circle
            AnimatedAlign(
              alignment:
                  isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
