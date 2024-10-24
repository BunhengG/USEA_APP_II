// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:useaapp_version_2/theme/constants.dart';
// import 'package:useaapp_version_2/theme/text_style.dart';
// import 'dart:io' show Platform;

// class DialogService {
//   static void showNoInternetDialog(BuildContext context) {
//     if (Platform.isAndroid) {
//       _showAndroidDialog(context);
//     } else if (Platform.isIOS) {
//       _showiOSDialog(context);
//     }
//   }

//   static void _showAndroidDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: AlertDialog(
//             backgroundColor: Colors.white.withOpacity(0.5),
//             title: Text(
//               "បច្ចុប្បន្នអ្នកនៅក្រៅបណ្តាញ".tr,
//               style: getTitleMediumTextStyle(),
//             ),
//             content: Text(
//               "សូមពិនិត្យមើលការកំណត់ និងបើកការតភ្ជាប់អ៊ីនធឺណិត។".tr,
//               style: getBodyMediumTextStyle().copyWith(
//                 color: cl_ThirdColor,
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: cl_ThirdColor,
//                 ),
//                 child: Text(
//                   "ការកំណត់".tr,
//                   style: getTitleSmallPrimaryColorTextStyle().copyWith(
//                     color: cl_PrimaryColor,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(dialogContext).pop();
//                   _openAndroidSettings();
//                 },
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   backgroundColor: cl_ThirdColor,
//                 ),
//                 child: Text(
//                   "យល់ព្រម".tr,
//                   style: getTitleSmallPrimaryColorTextStyle().copyWith(
//                     color: cl_PrimaryColor,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(dialogContext).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//       useRootNavigator: true,
//     );
//   }

//   // iOS-specific dialog with blur effect
//   static void _showiOSDialog(BuildContext context) {
//     showCupertinoDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: CupertinoAlertDialog(
//             title: Text(
//               "បច្ចុប្បន្នអ្នកនៅក្រៅបណ្តាញ".tr,
//               style: getTitleMediumTextStyle(),
//             ),
//             content: Text(
//               "សូមពិនិត្យមើលការកំណត់ និងបើកការតភ្ជាប់អ៊ីនធឺណិត។".tr,
//               style: getBodyMediumTextStyle().copyWith(
//                 color: cl_ThirdColor,
//               ),
//             ),
//             actions: <Widget>[
//               CupertinoDialogAction(
//                 child: Text(
//                   "យល់ព្រម".tr,
//                   style: getTitleSmallPrimaryColorTextStyle().copyWith(
//                     color: cl_PrimaryColor,
//                   ),
//                 ),
//                 onPressed: () {
//                   // _openIOSSettings();
//                   Navigator.of(dialogContext).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Open Android Wi-Fi settings
//   static void _openAndroidSettings() async {
//     const intent = AndroidIntent(
//       action: 'android.settings.WIFI_SETTINGS',
//       flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//     );
//     await intent.launch();
//   }

//   // Open iOS settings
//   static void _openIOSSettings() async {
//     const url = 'App-Prefs:root=WIFI';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not open settings';
//     }
//   }
// }