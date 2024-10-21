import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../GuestDashboard/Screen/HomeScreen/home_screen.dart';
import '../StudentDashboard/Screens/StudentHomeScreen/UI/HomePage.dart';
import '../StudentDashboard/helpers/shared_pref_helper.dart';
import '../UsersScreen/Multiple_Users.dart';
import '../theme/constants.dart';
import '../theme/text_style.dart';

class CustomStudentBottomBar extends StatefulWidget {
  final int initialIndex;
  const CustomStudentBottomBar({super.key, this.initialIndex = 0});

  @override
  State<CustomStudentBottomBar> createState() => _CustomStudentBottomBarState();
}

class _CustomStudentBottomBarState extends State<CustomStudentBottomBar> {
  late int _selectedIndex;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Method to handle tab changes
  void _onTabChange(int index) async {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        await Navigator.push(
          context,
          SwipeablePageRoute(
            builder: (context) => HomeScreen(initialIndex: index),
          ),
        );
        break;
      case 1:
        _showLanguageDialog();
        break;
      case 2:
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();

        if (studentId != null && password != null) {
          await Navigator.push(
            context,
            SwipeablePageRoute(
              builder: (context) => StudentHomePage(initialIndex: index),
            ),
          );
        } else {
          await Navigator.push(
            context,
            SwipeablePageRoute(
              builder: (context) => const MultipleUsers(),
            ),
          );
        }
        break;
    }
  }

  // Method to show the language selection dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: cl_ThirdColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Language',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cl_PrimaryColor,
                          fontFamily: ft_Eng,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Please select a language',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cl_PrimaryColor,
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
                        onPressed: () {
                          Get.updateLocale(const Locale('en'));
                          Navigator.of(context).pop();
                          _returnToPreviousPage();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icon/united-kingdom.png',
                              width: 46,
                            ),
                            const Text(
                              'English',
                              style: TextStyle(
                                color: cl_PrimaryColor,
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
                        onPressed: () {
                          Get.updateLocale(const Locale('km'));
                          Navigator.of(context).pop();
                          _returnToPreviousPage();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icon/cambodia.png',
                              width: 46,
                            ),
                            const Text(
                              'Khmer',
                              style: TextStyle(
                                color: cl_PrimaryColor,
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
    return Container(
      color: context.bottomBGColor,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
          top: 12,
          right: 16,
          left: 16,
        ),
        child: GNav(
          gap: 6,
          color: context.bottomColor,
          activeColor: cl_ThirdColor,
          backgroundColor: Colors.transparent,
          tabBackgroundColor: context.bottomColor,
          padding: const EdgeInsets.all(14.0),
          selectedIndex: _selectedIndex, // Bind selected index here
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
