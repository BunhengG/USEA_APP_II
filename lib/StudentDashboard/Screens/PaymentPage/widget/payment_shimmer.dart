import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/utils/theme_provider/theme_utils.dart';

class PaymentShimmer extends StatelessWidget {
  const PaymentShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Shimmer.fromColors(
          baseColor: colorMode ? cl_ItemBackgroundColor : cl_SecondaryColor,
          highlightColor: colorMode
              ? Colors.grey[300]!
              : cl_SecondaryColor.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Placeholder
              Container(
                width: 150.w,
                height: 26.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(rd_SmallRounded),
                ),
              ),
              const SizedBox(height: 16),

              // Circular Image Placeholder
              Container(
                width: double.infinity,
                height: 240.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(rd_MediumRounded),
                ),
              ),
              const SizedBox(height: 26.0),

              // Title Placeholder
              Container(
                width: 250.w,
                height: 26.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(rd_SmallRounded),
                ),
              ),
              const SizedBox(height: 16),
              // Payment Card Placeholder
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [sd_BoxShadow],
                  borderRadius: BorderRadius.circular(rd_MediumRounded),
                  color: Colors.grey[300]!,
                ),
                width: double.infinity,
                height: 150.h,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Eye Icon Placeholder
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            width: 30.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Description Placeholder
                      Container(
                        width: 180.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Amount Placeholder
                      Container(
                        width: 100.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const Spacer(),
                      // Remaining Amount Placeholder
                      Container(
                        width: 80.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Add more placeholders if needed for additional payments
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [sd_BoxShadow],
                  borderRadius: BorderRadius.circular(rd_MediumRounded),
                  color: Colors.grey[300]!,
                ),
                width: double.infinity,
                height: 150.h,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Eye Icon Placeholder
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            width: 30.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Description Placeholder
                      Container(
                        width: 180.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Amount Placeholder
                      Container(
                        width: 100.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const Spacer(),
                      // Remaining Amount Placeholder
                      Container(
                        width: 80.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300]!,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
