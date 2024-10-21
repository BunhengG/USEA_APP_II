import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';

import '../../theme/constants.dart';
import '../../theme/text_style.dart';

class StudentMultiAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackButtonPressed;

  const StudentMultiAppBar({
    required this.title,
    required this.onBackButtonPressed,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      titleSpacing: 5,
      flexibleSpace: Container(
        decoration: BoxDecoration(color: context.appBarColor),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: cl_ThirdColor,
              size: 22,
            ),
            onPressed: onBackButtonPressed,
          ),
          Expanded(
            child: Text(
              title.tr,
              style: getTitleMediumTextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
