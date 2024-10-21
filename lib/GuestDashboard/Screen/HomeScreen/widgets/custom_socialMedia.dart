import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:useaapp_version_2/theme/constants.dart';

import '../../../../theme/theme_provider/theme_utils.dart';

class CustomSocialmedia extends StatefulWidget {
  const CustomSocialmedia({super.key});

  @override
  State<CustomSocialmedia> createState() => _CustomSocialmediaState();
}

class _CustomSocialmediaState extends State<CustomSocialmedia> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode
            .externalApplication, // Opens the URL with an external browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const double spaceBetweenIcons = 14.0;
    final colorMode = isDarkMode(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _launchURL('https://www.facebook.com/usea.edu.kh/'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/facebook.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
          const SizedBox(width: spaceBetweenIcons),
          GestureDetector(
            onTap: () => _launchURL('https://bit.ly/usea_ig'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/instagram.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
          const SizedBox(width: spaceBetweenIcons),
          GestureDetector(
            onTap: () => _launchURL('https://bit.ly/usea_yt'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/youtube.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
          const SizedBox(width: spaceBetweenIcons),
          GestureDetector(
            onTap: () => _launchURL('https://bit.ly/usea_telegram'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/telegram.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
          const SizedBox(width: spaceBetweenIcons),
          GestureDetector(
            onTap: () => _launchURL('https://bit.ly/usea_tiktok'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/tiktok.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
          const SizedBox(width: spaceBetweenIcons),
          GestureDetector(
            onTap: () => _launchURL('https://bit.ly/3uzmy2x'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/website.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
          const SizedBox(width: spaceBetweenIcons),
          GestureDetector(
            onTap: () => _launchURL('https://www.linkedin.com'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: colorMode ? cl_SecondaryColor : cl_ThirdColor,
                ),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Image.asset(
                'assets/icon/linkedin.png',
                width: 40.0,
                height: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
