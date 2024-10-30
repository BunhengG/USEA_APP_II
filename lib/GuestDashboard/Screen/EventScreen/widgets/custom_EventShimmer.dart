import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        color: cl_ItemBackgroundColor,
        borderRadius: BorderRadius.circular(rd_MediumRounded),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for the image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(rd_MediumRounded),
            ),
            child: Shimmer.fromColors(
              baseColor: cl_ItemBackgroundColor,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: 180.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for the title
                Shimmer.fromColors(
                  baseColor: cl_ItemBackgroundColor,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 14.0,
                    width: 180.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Shimmer for the body text
                Shimmer.fromColors(
                  baseColor: cl_ItemBackgroundColor,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Shimmer for the date and time row
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 10.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Shimmer.fromColors(
                      baseColor: cl_ItemBackgroundColor,
                      highlightColor: Colors.grey[300]!,
                      child: Container(
                        height: 10.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
