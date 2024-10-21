// lib/components/shimmer_contact.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:useaapp_version_2/theme/constants.dart';

class ShimmerContact extends StatelessWidget {
  const ShimmerContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: cl_ItemBackgroundColor,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(1, (index) => _buildShimmerContactSection()),
      ),
    );
  }

  Widget _buildShimmerContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rd_SmallRounded),
          color: cl_ItemBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(rd_SmallRounded),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(rd_SmallRounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 200,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(rd_SmallRounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
