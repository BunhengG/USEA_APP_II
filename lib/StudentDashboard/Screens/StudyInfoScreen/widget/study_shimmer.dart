import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/constants.dart'; // Ensure you have the shimmer package added to your pubspec.yaml

class StudyShimmer extends StatelessWidget {
  const StudyShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 340.h,
        decoration: const BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(rd_MediumRounded)),
          boxShadow: [sd_BoxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerHeader(),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildListText(),
                  const SizedBox(height: 8),
                  _buildListText(),
                  const SizedBox(height: 8),
                  _buildListText(),
                  const SizedBox(height: 8),
                  _buildListText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerHeader() {
    return Shimmer.fromColors(
      baseColor: cl_ItemBackgroundColor,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(rd_MediumRounded),
            topRight: Radius.circular(rd_MediumRounded),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildShimmerTextHeader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListText() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildShimmerHeaderTitle(),
          const SizedBox(width: 16),
          _buildShimmerText(),
        ],
      ),
    );
  }

  Widget _buildShimmerHeaderTitle() {
    return Shimmer.fromColors(
      baseColor: cl_ItemBackgroundColor,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: cl_ItemBackgroundColor,
        ),
        height: 16,
        width: 90.w,
      ),
    );
  }
}

Widget _buildShimmerTextHeader() {
  return Shimmer.fromColors(
    baseColor: cl_ItemBackgroundColor,
    highlightColor: Colors.grey[100]!,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: cl_ItemBackgroundColor,
      ),
      height: 16,
      width: 150.w,
    ),
  );
}

Widget _buildShimmerText() {
  return Shimmer.fromColors(
    baseColor: cl_ItemBackgroundColor,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 16,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: cl_ItemBackgroundColor,
      ),
    ),
  );
}
