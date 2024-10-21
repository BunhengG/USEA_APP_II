


// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:useaapp_version_2/theme/color_builder.dart';

// import '../func/shared_pref_language.dart';
// import '../theme/constants.dart';

// void showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           // backgroundColor: cl_ThirdColor,
//           backgroundColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(rd_MediumRounded),
//           ),
//           child: Stack(
//             children: [
//               // BackdropFilter to create the blur effect
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: MediaQuery.of(context).size.width * 0.5,
//                   decoration: BoxDecoration(
//                     color: cl_ThirdColor.withOpacity(0.6),
//                     borderRadius: BorderRadius.circular(rd_MediumRounded),
//                   ),
//                 ),
//               ),
//               Container(
//                 constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 0.5,
//                   minWidth: MediaQuery.of(context).size.width * 0.5,
//                 ),
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             'ភាសា'.tr,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: context.subTitlePrimaryColor,
//                               fontFamily: ft_Eng,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'សូមជ្រើសរើសភាសា'.tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: context.subTitlePrimaryColor,
//                         fontFamily: ft_Eng,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12.0,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () async {
//                               Get.updateLocale(const Locale('en'));
//                               await SharedPrefHelperLanguage.setLanguageCode(
//                                   'en');
//                               Navigator.of(context).pop();
//                               _returnToPreviousPage();
//                             },
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   'assets/icon/united-kingdom.png',
//                                   width: 46,
//                                 ),
//                                 Text(
//                                   'ភាសាអង់គ្លេស'.tr,
//                                   style: TextStyle(
//                                     color: context.subTitlePrimaryColor,
//                                     fontFamily: ft_Eng,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 1,
//                           color: cl_SecondaryColor,
//                           height: 50,
//                         ),
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () async {
//                               Get.updateLocale(const Locale('km'));
//                               await SharedPrefHelperLanguage.setLanguageCode(
//                                   'km');
//                               Navigator.of(context).pop();
//                               _returnToPreviousPage();
//                             },
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   'assets/icon/cambodia.png',
//                                   width: 46,
//                                 ),
//                                 Text(
//                                   'ភាសាខ្មែរ'.tr,
//                                   style: TextStyle(
//                                     color: context.subTitlePrimaryColor,
//                                     fontFamily: ft_Eng,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }


//    void _returnToPreviousPage() {
//     setState(() {
//       _selectedIndex = _previousIndex;
//     });
//   }