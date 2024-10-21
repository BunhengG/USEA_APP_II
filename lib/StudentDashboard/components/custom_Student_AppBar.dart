import 'package:flutter/material.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../theme/constants.dart';
import '../../GuestDashboard/NotificationScreen/notification_screen.dart';
import '../../theme/theme_provider/theme_utils.dart';

class CustomStudentAppBarMode extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomStudentAppBarMode({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomStudentAppBarModeState createState() =>
      _CustomStudentAppBarModeState();
}

class _CustomStudentAppBarModeState extends State<CustomStudentAppBarMode> {
  bool isSwitched = false; // State for the switch

  @override
  Widget build(BuildContext context) {
    const titleKh = 'សាកលវិទ្យាល័យ សៅស៍អុីសថ៍អេយសៀ';
    const titleEn = 'University of South-East Asia';

    final colorMode = isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: colorMode ? cl_ThirdColor : cl_ThirdColor,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.appBarColor,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon/logo.png',
                    height: 46.0,
                    width: 46.0,
                  ),
                  const SizedBox(width: 3.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        titleKh,
                        style: TextStyle(
                          color: context.titleAppBarColor,
                          fontSize: 12.0,
                          fontFamily: ft_Khmer,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        titleEn.toUpperCase(),
                        style: TextStyle(
                          color: context.titleAppBarColor,
                          fontSize: 12.0,
                          fontFamily: ft_Khmer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 0.1),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icon/notification.png',
                    width: 18.0,
                    height: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
