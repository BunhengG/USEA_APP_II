import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../theme/constants.dart';

class ShimmerVideoListItem extends StatelessWidget {
  const ShimmerVideoListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rd_MediumRounded),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: cl_ItemBackgroundColor,
        highlightColor: Colors.grey[300]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(rd_MediumRounded),
              child: Container(
                width: double.infinity,
                height: 180,
                color: cl_ThirdColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 18.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rd_SmallRounded),
                      color: cl_ThirdColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: 150.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rd_SmallRounded),
                      color: cl_ThirdColor,
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
