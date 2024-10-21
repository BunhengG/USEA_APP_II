import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../theme/constants.dart';

class RegistrationShimmerLoader extends StatelessWidget {
  const RegistrationShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(rd_MediumRounded),
              color: cl_ItemBackgroundColor,
            ),
            margin: const EdgeInsets.only(
              bottom: 16,
              top: 8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(rd_MediumRounded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Skeleton with Shimmer animation
                  Shimmer.fromColors(
                    baseColor: cl_ItemBackgroundColor,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 46.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(rd_SmallRounded),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(
                    thickness: 0.5,
                    color: cl_SecondaryColor,
                  ),
                  const SizedBox(height: 8.0),
                  for (var i = 0; i < 3; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                              baseColor: cl_ItemBackgroundColor,
                              highlightColor: Colors.grey[300]!,
                              // ?Icon
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(rd_FullRounded),
                                  color: Colors.grey[300],
                                ),
                                height: 38,
                                width: 38,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // ?Text
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor: cl_ItemBackgroundColor,
                                highlightColor: Colors.grey[300]!,
                                child: Container(
                                  height: 28.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Shimmer.fromColors(
                          baseColor: cl_ItemBackgroundColor,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            margin: const EdgeInsets.only(left: 26),
                            height: 46.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
