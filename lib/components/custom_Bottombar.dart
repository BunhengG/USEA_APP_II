import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../GuestDashboard/Screen/HomeScreen/home_screen.dart';
import '../StudentDashboard/Screens/StudentHomeScreen/UI/HomePage.dart';
import '../StudentDashboard/helpers/shared_pref_helper.dart';
import '../UsersScreen/Multiple_Users.dart';
import '../func/shared_pref_language.dart';
import '../theme/constants.dart';
import '../theme/text_style.dart';
import '../theme/theme_provider/theme_utils.dart';

class CustomBottombar extends StatefulWidget {
  final int initialIndex;
  const CustomBottombar({super.key, this.initialIndex = 0});

  @override
  State<CustomBottombar> createState() => _CustomBottombarState();
}

class _CustomBottombarState extends State<CustomBottombar> {
  late int _selectedIndex;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    // Use WidgetsBinding to run code after the build
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        precacheImage(AssetImage('assets/icon/united-kingdom.png'), context);
        precacheImage(AssetImage('assets/icon/cambodia.png'), context);
      },
    );
  }

  // Method to handle tab changes
  void _onTabChange(int index) async {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        await Get.to(() => HomeScreen(initialIndex: index),
            transition: Transition.noTransition);
        break;
      case 1:
        _showLanguageDialog(context);
        break;
      case 2:
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();

        if (studentId != null && password != null) {
          await Get.to(() => StudentHomePage(initialIndex: index),
              transition: Transition.noTransition);
        } else {
          await Get.to(() => const MultipleUsers(),
              transition: Transition.noTransition);
          if (mounted) {
            setState(() {
              _selectedIndex = 0;
            });
          }
        }
        break;
    }
  }

  // Method to show the language selection dialog
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          // backgroundColor: cl_ThirdColor,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rd_MediumRounded),
          ),
          child: Stack(
            children: [
              // BackdropFilter to create the blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: cl_ThirdColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(rd_MediumRounded),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'ភាសា'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context.subTitlePrimaryColor,
                              fontFamily: ft_Eng,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'សូមជ្រើសរើសភាសា'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.subTitlePrimaryColor,
                        fontFamily: ft_Eng,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Get.updateLocale(const Locale('en'));
                              await SharedPrefHelperLanguage.setLanguageCode(
                                  'en');
                              Navigator.of(context).pop();
                              _returnToPreviousPage();
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icon/united-kingdom.png',
                                  width: 46,
                                ),
                                Text(
                                  'ភាសាអង់គ្លេស'.tr,
                                  style: TextStyle(
                                    color: context.subTitlePrimaryColor,
                                    fontFamily: ft_Eng,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: cl_SecondaryColor,
                          height: 50,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              Get.updateLocale(const Locale('km'));
                              await SharedPrefHelperLanguage.setLanguageCode(
                                  'km');
                              Navigator.of(context).pop();
                              _returnToPreviousPage();
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icon/cambodia.png',
                                  width: 46,
                                ),
                                Text(
                                  'ភាសាខ្មែរ'.tr,
                                  style: TextStyle(
                                    color: context.subTitlePrimaryColor,
                                    fontFamily: ft_Eng,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _returnToPreviousPage() {
    setState(() {
      _selectedIndex = _previousIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);

    Color bottomBarColor;

    if ((_previousIndex == 0 && _selectedIndex == 1) ||
        (_previousIndex == 1 && _selectedIndex == 0)) {
      bottomBarColor = cl_ThirdColor;
    } else if (_selectedIndex == 2 || _selectedIndex == 1) {
      bottomBarColor = colorMode ? cl_darkMode : cl_ThirdColor;
    } else if (_previousIndex == 0 && _selectedIndex == 1) {
      bottomBarColor = colorMode ? cl_darkMode : cl_ThirdColor;
    } else {
      bottomBarColor = cl_ThirdColor;
    }

    return Container(
      color: bottomBarColor,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 8,
          top: 8,
          right: 16,
          left: 16,
        ),
        child: GNav(
          gap: 6,
          color: cl_BGIconDarkMode,
          activeColor: cl_ThirdColor,
          backgroundColor: Colors.transparent,
          tabBackgroundColor: cl_PrimaryColor,
          padding: const EdgeInsets.all(14.0),
          selectedIndex: _selectedIndex,
          onTabChange: _onTabChange,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.house,
              iconSize: 18,
              text: 'ទំព័រដើម'.tr,
              textStyle: getTitleMediumTextStyle(),
            ),
            GButton(
              icon: FontAwesomeIcons.globe,
              iconSize: 18,
              text: 'ផ្លាស់ប្ដូរភាសា'.tr,
              textStyle: getTitleMediumTextStyle(),
            ),
            GButton(
              icon: FontAwesomeIcons.solidUser,
              iconSize: 18,
              text: 'ចូលគណនី'.tr,
              textStyle: getTitleMediumTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
