import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadiusGeometry borderRadius;

  const ShimmerPlaceholder({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      child: Shimmer.fromColors(
        baseColor: cl_ItemBackgroundColor,
        highlightColor: Colors.grey[300]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Image Placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                borderRadius: BorderRadius.circular(rd_MediumRounded),
              ),
            ),
            const SizedBox(width: 16.0),
            // Title and Subtitle Placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Placeholder
                  Container(
                    width: double.infinity,
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Subtitle Placeholder
                  Container(
                    height: 16.0,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: 200,
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
