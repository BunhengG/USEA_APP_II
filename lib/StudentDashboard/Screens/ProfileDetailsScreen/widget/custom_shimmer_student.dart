import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const CustomShimmerContainer({
    Key? key,
    this.height = 200.0,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
