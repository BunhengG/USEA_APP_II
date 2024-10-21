import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';

class AttendanceListShimmer extends StatelessWidget {
  const AttendanceListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Horizontal Scrollable TabBar Shimmer
          _buildTabBarShimmer(),
          SizedBox(height: 8.h),
          const Expanded(
            child: AttendanceShimmer(
              height: 40,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal Scrollable TabBar Shimmer
  Widget _buildTabBarShimmer() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 16.0 : 8.0,
              right: 2,
            ),
            child: _buildTabShimmer(),
          ),
        ),
      ),
    );
  }

  // Shimmer for TabBar items
  Widget _buildTabShimmer() {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: cl_ThirdColor,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(rd_SmallRounded),
      ),
      child: Container(
        height: 50.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: BorderRadius.circular(rd_SmallRounded),
        ),
        alignment: Alignment.center,
        child: Shimmer.fromColors(
          baseColor: cl_ItemBackgroundColor,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 20.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: cl_ItemBackgroundColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}

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
      padding: EdgeInsets.symmetric(
        vertical: 8.0.h,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildTabView();
              },
            ),
          ),
          SizedBox(height: 8.h),
          _buildTitle(),
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

  Widget _buildTitle() {
    return Shimmer.fromColors(
      baseColor: cl_ItemBackgroundColor,
      highlightColor: Colors.grey[300]!,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
          top: 16,
        ),
        width: 80,
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: BorderRadius.circular(rd_SmallRounded),
        ),
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
