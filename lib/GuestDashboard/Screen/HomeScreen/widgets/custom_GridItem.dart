import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:useaapp_version_2/theme/constants.dart';

import '../../../../theme/text_style.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const GridItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cl_ItemBackgroundColor,
          borderRadius: BorderRadius.circular(rd_LargeRounded),
          border: Border.all(
            color: cl_ThirdColor,
            width: 1.2,
          ),
          boxShadow: const [sd_BoxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 46,
              width: 46,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: cl_SecondaryColor,
                borderRadius: BorderRadius.circular(rd_FullRounded),
              ),
              child: Image.asset(
                iconPath,
                height: 36,
                width: 36,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              title,
              style: getTitleMediumPrimaryColorTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
