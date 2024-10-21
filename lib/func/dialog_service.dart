import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'dart:io' show Platform;

import '../theme/text_style.dart';

class DialogService {
  static void showNoInternetDialog(BuildContext context) {
    if (Platform.isAndroid) {
      _showAndroidDialog(context);
    } else if (Platform.isIOS) {
      _showiOSDialog(context);
    }
  }

  static void _showAndroidDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "បច្ចុប្បន្នអ្នកនៅក្រៅបណ្តាញ".tr,
            style: getTitleMediumPrimaryColorTextStyle(),
          ),
          content: Text(
            "សូមពិនិត្យមើលការកំណត់នៃការតភ្ជាប់អ៊ីនធឺណិតរបស់អ្នកម្ដងទៀត។".tr,
            style: getBodyMediumTextStyle().copyWith(
              fontSize: 14,
              height: 1.5,
              color: Colors.redAccent[100],
            ),
          ),
          actions: <Widget>[
            //? Button Dismissed
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: cl_PrimaryColor,
              ),
              child: Text(
                "យល់ព្រម".tr,
                style: getTitleSmallPrimaryColorTextStyle().copyWith(
                  color: cl_ThirdColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static void _showiOSDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            "បច្ចុប្បន្នបណ្តាញអ៊ីនធឺណិតគឹបានបិទ".tr,
            style: getTitleMediumPrimaryColorTextStyle(),
          ),
          content: Text(
            "សូមពិនិត្យមើលការកំណត់ និងបើកការតភ្ជាប់អ៊ីនធឺណិត។".tr,
            style: getBodyMediumTextStyle().copyWith(
              fontSize: 14,
              color: Colors.redAccent[100],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "យល់ព្រម".tr,
                style: getTitleSmallPrimaryColorTextStyle().copyWith(
                  color: cl_PrimaryColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
