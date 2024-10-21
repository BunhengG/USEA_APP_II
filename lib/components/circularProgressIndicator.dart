import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ColorfulCircularProgressIndicator(
        colors: [
          Color(0xFFE4AC3F),
          Color(0xFFFFFFFF),
          Color(0xFFBF1515),
          Color(0xFF3E4095),
        ],
        strokeWidth: 4,
        indicatorHeight: 36,
        indicatorWidth: 36,
      ),
    );
  }
}
