// lib/widgets/shimmer_grid_placeholder.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/constants.dart';

class ShimmerGridPlaceholder extends StatelessWidget {
  final int itemCount;

  const ShimmerGridPlaceholder({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.8 / 3,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: cl_ItemBackgroundColor,
            borderRadius: BorderRadius.circular(rd_MediumRounded),
          ),
          child: Shimmer.fromColors(
            baseColor: cl_ItemBackgroundColor,
            highlightColor: Colors.grey[300]!,
            child: Container(
              decoration: BoxDecoration(
                color: cl_ItemBackgroundColor,
                borderRadius: BorderRadius.circular(rd_MediumRounded),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(rd_MediumRounded),
                          topRight: Radius.circular(rd_MediumRounded),
                        ),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 26,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(rd_MediumRounded),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 36.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(rd_MediumRounded),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
