import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';

class AttendanceShimmer extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadiusGeometry borderRadius;
  final int itemCount;

  const AttendanceShimmer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = BorderRadius.zero,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 4),
            height: 40,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildTabView();
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return _buildAttendanceList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: cl_ItemBackgroundColor,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: cl_ItemBackgroundColor,
                borderRadius: BorderRadius.circular(rd_FullRounded),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Shimmer.fromColors(
            baseColor: cl_ItemBackgroundColor,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: 46,
              height: 20,
              decoration: BoxDecoration(
                color: cl_ItemBackgroundColor,
                borderRadius: BorderRadius.circular(rd_SmallRounded),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method that builds a single shimmer item
  Widget _buildAttendanceList() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: cl_ItemBackgroundColor,
        borderRadius: BorderRadius.circular(rd_MediumRounded),
      ),
      child: Shimmer.fromColors(
        baseColor: cl_ItemBackgroundColor,
        highlightColor: Colors.grey[300]!,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            // Circular Image Placeholder
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300]!,
                borderRadius: BorderRadius.circular(rd_SmallRounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
