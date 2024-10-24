

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../theme/constants.dart';
import '../theme/text_style.dart';

class DialogService {
  static void showNoInternetDialog(BuildContext context) {
    // Check the platform and show the appropriate dialog
    if (Platform.isAndroid) {
      _showDialog(context, isIOS: false);
    } else if (Platform.isIOS) {
      _showDialog(context, isIOS: true);
    }
  }

  // Generalized method to show platform-specific dialogs
  static void _showDialog(BuildContext context, {required bool isIOS}) {
    final dialogContent = _buildDialogContent();

    if (isIOS) {
      _showCupertinoDialog(context, dialogContent);
    } else {
      _showMaterialDialog(context, dialogContent);
    }
  }

  // Builds the content for the dialog
  static Widget _buildDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "បច្ចុប្បន្នអ្នកនៅក្រៅបណ្តាញ".tr,
          style: getTitleMediumTextStyle(),
        ),
        SizedBox(height: 10),
        Text(
          "សូមពិនិត្យមើលការកំណត់ និងបើកការតភ្ជាប់អ៊ីនធឺណិត។".tr,
          style: getBodyMediumTextStyle().copyWith(color: cl_ThirdColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Method to show iOS-specific dialog
  static void _showCupertinoDialog(BuildContext context, Widget content) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: CupertinoAlertDialog(
            content: content,
            actions: [
              CupertinoDialogAction(
                child: Text(
                  "យល់ព្រម".tr,
                  style: getTitleSmallPrimaryColorTextStyle()
                      .copyWith(color: cl_PrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to show Android-specific dialog
  static void _showMaterialDialog(BuildContext context, Widget content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.5),
            content: content,
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: cl_ThirdColor),
                child: Text(
                  "ការកំណត់".tr,
                  style: getTitleSmallPrimaryColorTextStyle()
                      .copyWith(color: cl_PrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  _openAndroidSettings();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: cl_ThirdColor),
                child: Text(
                  "យល់ព្រម".tr,
                  style: getTitleSmallPrimaryColorTextStyle()
                      .copyWith(color: cl_PrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Open Android Wi-Fi settings
  static void _openAndroidSettings() async {
    try {
      const intent = AndroidIntent(
        action: 'android.settings.WIFI_SETTINGS',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    } catch (e) {
      // Optional: Show an error message if settings cannot be opened
      _showErrorMessage('Unable to open Wi-Fi settings.');
    }
  }

  // Open iOS settings (optional if needed)
  static void _openIOSSettings() async {
    const url = 'App-Prefs:root=WIFI';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Optional: Show an error message if settings cannot be opened
      _showErrorMessage('Unable to open Wi-Fi settings.');
    }
  }

  // Show a snackbar or toast message for errors
  static void _showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
    );
  }
}
