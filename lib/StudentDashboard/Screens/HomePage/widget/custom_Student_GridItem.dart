import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';

import '../../../../theme/text_style.dart';
import '../../../../utils/theme_provider/theme_utils.dart';

class CustomStudentGridItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const CustomStudentGridItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //COMMENT: Check current theme mode
    final colorMode = isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorDarkMode,
          borderRadius: BorderRadius.circular(rd_LargeRounded),
          border: Border.all(
            color: colorMode ? Colors.transparent : cl_ThirdColor,
            width: 1.2,
          ),
          boxShadow: [colorMode ? sd_BoxShadowMode : sd_BoxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 46,
              width: 46,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: context.iconColor,
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
              style: getTitleMediumPrimaryColorTextStyle().copyWith(
                color: context.subTitlePrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
