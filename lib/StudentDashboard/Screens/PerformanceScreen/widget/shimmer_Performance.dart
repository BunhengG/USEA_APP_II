import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';

class CustomShimmerPerformancePage extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final BorderRadius borderRadius;

  const CustomShimmerPerformancePage({
    super.key,
    this.cardHeight = 400.0,
    this.cardWidth = double.infinity,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(rd_SmallRounded)),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),

        // Horizontal Scrollable TabBar Shimmer
        _buildTabBarShimmer(),

        SizedBox(height: 8.h),

        // Card Shimmer
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: 2, // Update this for more cards
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Shimmer.fromColors(
                  baseColor: cl_ItemBackgroundColor,
                  highlightColor: Colors.grey[300]!,
                  child: _buildCardShimmer(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Horizontal Scrollable TabBar Shimmer
  Widget _buildTabBarShimmer() {
    return SingleChildScrollView(
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
        borderRadius: borderRadius,
      ),
      child: Container(
        height: 50.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: borderRadius,
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

  // Shimmer for the cards
  Widget _buildCardShimmer() {
    return Container(
      height: 480.h,
      width: cardWidth,
      decoration: BoxDecoration(
        color: cl_ItemBackgroundColor,
        borderRadius: BorderRadius.circular(rd_LargeRounded),
        boxShadow: const [sd_BoxShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCardHeaderShimmer(),
          _buildBodyShimmer(),
          SizedBox(height: 8.h),
          _buildFooterShimmer(),
        ],
      ),
    );
  }

  Widget _buildCardHeaderShimmer() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: cl_ItemBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: _buildHeaderListShimmer(),
    );
  }

  Widget _buildBodyShimmer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: _buildBodyListShimmer(),
          );
        },
      ),
    );
  }

  Widget _buildFooterShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 100.h,
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: BorderRadius.circular(rd_LargeRounded),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildFooterListShimmer(),
        ),
      ),
    );
  }

  Widget _buildHeaderListShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShimmerContainer(height: 24.h, width: 80.w),
        const SizedBox(width: 60),
        _buildShimmerContainer(height: 24.h, width: 60.w),
        _buildShimmerContainer(height: 24.h, width: 60.w),
      ],
    );
  }

  Widget _buildBodyListShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShimmerContainer(height: 20.h, width: 160.w),
        _buildShimmerContainer(height: 20.h, width: 50.w),
        _buildShimmerContainer(height: 20.h, width: 60.w),
      ],
    );
  }

  Widget _buildFooterListShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShimmerContainer(height: 26.h, width: 90.w),
        _buildShimmerContainer(height: 26.h, width: 80.w),
      ],
    );
  }

  // Helper method to build shimmer containers
  // Widget _buildShimmerContainer(
  //     {required double height, required double width}) {
  //   return Shimmer.fromColors(
  //     baseColor: cl_ItemBackgroundColor,
  //     highlightColor: Colors.grey[300]!,
  //     child: Container(
  //       height: height,
  //       width: width,
  //       decoration: BoxDecoration(
  //         color: Colors.grey[300],
  //         borderRadius: BorderRadius.circular(4.0),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildShimmerContainer(
      {required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
