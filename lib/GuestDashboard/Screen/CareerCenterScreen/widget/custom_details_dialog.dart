// career_details_dialog.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../model/careerCenterModel.dart';

void showCareerDetailsDialog(BuildContext context, Career career) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      // Animation to make the slide-in smoother
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: cl_ThirdColor,
                    borderRadius: BorderRadius.circular(rd_LargeRounded),
                    boxShadow: const [sd_BoxShadow],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //! Header Content
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(rd_SmallRounded),
                              color: Colors.white54,
                              boxShadow: const [sd_BoxShadow],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(rd_SmallRounded),
                              child: Image.network(
                                career.logo,
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Title
                          Expanded(
                            child: Text(
                              career.position,
                              style: getTitleSmallPrimaryColorTextStyle(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      //! Divider
                      Container(
                        width: double.infinity,
                        height: 3,
                        decoration: BoxDecoration(
                          color: cl_PrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(rd_SmallRounded),
                        ),
                      ),
                      const SizedBox(height: 16),
                      //! Body Content
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(rd_FullRounded),
                                    color:
                                        const Color.fromARGB(44, 24, 78, 255),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.briefcase,
                                    color: cl_PrimaryColor,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    '${'ស្ថាប័ន៖ '.tr}${career.organization}',
                                    style: getBodyMediumTextStyle()
                                        .copyWith(fontSize: 13),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    maxLines: null,
                                  ),
                                ),
                              ],
                            ),
                            SdH_SizeBox_S,
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(rd_FullRounded),
                                    color:
                                        const Color.fromARGB(45, 0, 171, 193),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.calendar,
                                    color: Colors.cyan[600],
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${'ថ្ងៃផុតកំណត់៖ '.tr}${career.expiredDate}',
                                  style: getBodyMediumCareerCenterTextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SdH_SizeBox_S,
                      //! Button Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                elevation: 0.5,
                                foregroundColor: cl_ThirdColor,
                                backgroundColor: const Color(0xFFCB6040),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(rd_SmallRounded),
                                ),
                              ),
                              child: Text(
                                'ចាំពេលក្រោយ'.tr.toUpperCase(),
                                style: getBodyMediumCareerCenterTextStyle()
                                    .copyWith(
                                  color: cl_ThirdColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _launchURL(career.link);
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF88C273),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'អានបន្ថែម'.tr.toUpperCase(),
                                style: getBodyMediumCareerCenterTextStyle()
                                    .copyWith(
                                  color: cl_ThirdColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
