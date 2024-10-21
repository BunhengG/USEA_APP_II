// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:open_settings/open_settings.dart';
// import 'package:open_settings_plus/open_settings_plus.dart';
// import 'package:useaapp_version_2/theme/constants.dart';
// import 'dart:io' show Platform;

// import '../theme/text_style.dart';

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
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "បច្ចុប្បន្នអ្នកនៅក្រៅបណ្តាញ".tr,
//             style: getTitleMediumPrimaryColorTextStyle(),
//           ),
//           content: Text(
//             "សូមពិនិត្យមើលការកំណត់នៃការតភ្ជាប់អ៊ីនធឺណិតរបស់អ្នកម្ដងទៀត។".tr,
//             style: getBodyMediumTextStyle().copyWith(
//               fontSize: 14,
//               color: Colors.redAccent[100],
//             ),
//           ),
//           actions: <Widget>[
//             // TextButton(
//             //   style: TextButton.styleFrom(
//             //     backgroundColor: Colors.blue.withOpacity(0.2),
//             //   ),
//             //   // child: Align(
//             //   //   alignment: Alignment.center,
//             //   child: Text(
//             //     "ចូលការកំណត់".tr,
//             //     style: getTitleSmallPrimaryColorTextStyle().copyWith(
//             //       color: Colors.blue,
//             //     ),
//             //   ),
//             //   // ),
//             //   onPressed: () {
//             //     _openAndroidSettings();
//             //     Navigator.of(context).pop();
//             //   },
//             // ),
//             //? Button Dismissed
//             TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: cl_PrimaryColor.withOpacity(0.2),
//               ),
//               child: Text(
//                 "យល់ព្រម".tr,
//                 style: getTitleSmallPrimaryColorTextStyle().copyWith(
//                   color: cl_PrimaryColor,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static void _showiOSDialog(BuildContext context) {
//     showCupertinoDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return CupertinoAlertDialog(
//           title: Text(
//             "បច្ចុប្បន្នបណ្តាញអ៊ីនធឺណិតគឹបានបិទ".tr,
//             style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
//           ),
//           content: Text(
//             "សូមពិនិត្យមើលការកំណត់ និងបើកការតភ្ជាប់អ៊ីនធឺណិត".tr,
//             style: CupertinoTheme.of(context).textTheme.textStyle,
//           ),
//           actions: <Widget>[
//             // Align(
//             //   alignment: Alignment.center,
//             //   child: CupertinoDialogAction(
//             //     child: Text(
//             //       "ចូលការកំណត់".tr,
//             //       style: getTitleSmallPrimaryColorTextStyle().copyWith(
//             //         color: cl_PrimaryColor,
//             //       ),
//             //     ),
//             //     onPressed: () {
//             //       _openIOSSettings();
//             //       Navigator.of(context).pop();
//             //     },
//             //   ),
//             // ),
//             CupertinoDialogAction(
//               child: Text(
//                 "យល់ព្រម".tr,
//                 style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
//                       color: cl_PrimaryColor,
//                     ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static void _openAndroidSettings() {
//     OpenSettings.openWIFISetting();
//   }

//   static void _openIOSSettings() {
//     final settings = OpenSettingsPlus.shared as OpenSettingsPlusIOS?;
//     settings?.cellular.call();
//   }
// }