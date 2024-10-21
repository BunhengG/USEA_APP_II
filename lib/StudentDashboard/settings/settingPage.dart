import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:useaapp_version_2/StudentDashboard/Screens/ProfilePage/UI/GetQrPage.dart';
import 'package:useaapp_version_2/utils/background.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';
import '../../GuestScreen/HomeScreen/home_screen.dart';
import '../../theme/constants.dart';
import '../../theme/text_style.dart';
import '../../utils/theme_provider/theme_provider.dart';
import '../../utils/theme_provider/theme_switch.dart';
import '../../utils/theme_provider/theme_utils.dart';
import '../auth/model/login_model_class.dart';
import '../components/custom_Student_Multi_Appbar.dart';
import '../helpers/shared_pref_helper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

//! Update
Future<void> _logout(BuildContext context) async {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: 'ចាកចេញពីគណនី?',
    text: 'តើអ្នកប្រាកដថាអ្នកនឹងចាកចេញពីគណនីនិសិ្សតដែរឬទេ?'.tr,
    confirmBtnText: 'ចាកចេញ'.tr,
    cancelBtnText: 'បោះបង់'.tr,
    headerBackgroundColor: cl_PrimaryColor,
    backgroundColor: cl_ThirdColor,
    borderRadius: 26,
    textColor: cl_TextColor,
    titleColor: cl_PrimaryColor,
    autoCloseDuration: const Duration(seconds: 5),
    confirmBtnColor: Colors.redAccent,
    cancelBtnTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: cl_TextColor,
    ),
    confirmBtnTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: cl_ThirdColor,
    ),
    onConfirmBtnTap: () {
      Navigator.pop(context);

      Future.delayed(const Duration(seconds: 1), () async {
        //* Clear StudentID and Password from SharedPreferences
        await SharedPrefHelper.clearStudentIdAndPassword();

        //! Clear all stored data on logout
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Reset the theme to light mode
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        await themeProvider.resetTheme();

        // Navigate to the HomeScreen after the delay
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      });
    },
    onCancelBtnTap: () {
      // Close the dialog when the user cancels
      Navigator.pop(context);
    },
  );
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkModeOn = false;

  @override
  Widget build(BuildContext context) {
    // Check current theme mode
    final colorMode = isDarkMode(context);

    return Scaffold(
      appBar: StudentMultiAppBar(
        title: 'ការកំណត់'.tr,
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: Stack(
        children: [
          BackgroundContainer(isDarkMode: colorMode),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Appearances Title
                Text(
                  'រូបរាង'.tr,
                  style: TextStyle(
                    color: cl_ThirdColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Appearances Container
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: context.bgThirdDarkMode,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      //? Night Mode Switch
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDarkModeOn = !isDarkModeOn;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ទម្រង់ងងឹត'.tr,
                                style: getTitleSmallPrimaryColorTextStyle()
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: context.subTitlePrimaryColor,
                                ),
                              ),
                              const ThemeSwitch(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                // Settings Title
                Text(
                  'ការកំណត់'.tr,
                  style: TextStyle(
                    color: cl_ThirdColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Settings Container
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: context.bgThirdDarkMode,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      //? Button to Navigate to Get QR Page
                      GestureDetector(
                        onTap: () async {
                          UserData? userData =
                              (await SharedPrefHelper.getStoredUserData());
                          String? studentId =
                              await SharedPrefHelper.getStudentId();
                          String? password =
                              await SharedPrefHelper.getPassword();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetQRPage(
                                studentId: studentId ?? 'N/A',
                                pwd: password ?? 'N/A',
                                profilePic: userData?.profilePic ?? 'N/A',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'បង្កើត QR'.tr,
                                style: getTitleSmallPrimaryColorTextStyle()
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: context.subTitlePrimaryColor,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.angleRight,
                                size: 24.0,
                                color: context.subTitlePrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      Divider(
                        color: context.secondaryColoDarkMode,
                        thickness: 1,
                        height: 20.h,
                      ),

                      //? Button Logout
                      GestureDetector(
                        onTap: () => _logout(context),
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ចាកចេញ'.tr,
                                style: getTitleSmallPrimaryColorTextStyle()
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: context.subTitlePrimaryColor,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.angleRight,
                                size: 24.0,
                                color: context.subTitlePrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
