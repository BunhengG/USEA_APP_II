import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../theme/constants.dart';
import '../theme/text_style.dart';

class MultiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackButtonPressed;

  const MultiAppBar({
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
        decoration: const BoxDecoration(color: Color(0xFF002060)),
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
