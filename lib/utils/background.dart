import 'package:flutter/material.dart';
import '../../theme/constants.dart';

class BackgroundContainer extends StatelessWidget {
  final bool isDarkMode;

  const BackgroundContainer({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: isDarkMode ? switchBackground : defaultBackground,
    );
  }
}
