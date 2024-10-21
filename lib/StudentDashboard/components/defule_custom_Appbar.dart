import 'package:flutter/material.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../GuestDashboard/NotificationScreen/notification_screen.dart';
import '../../theme/constants.dart';

class CustomStudentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomStudentAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const titleKh = 'សាកលវិទ្យាល័យ សៅស៍អុីសថ៍អេយសៀ';
    const titleEn = 'University of South-East Asia';
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF002060)),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.appBarColor,
        elevation: 0.0,
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
                      const Text(
                        titleKh,
                        style: TextStyle(
                          color: cl_SecondaryColor,
                          fontSize: 12.0,
                          fontFamily: ft_Khmer,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        titleEn.toUpperCase(),
                        style: const TextStyle(
                          color: cl_SecondaryColor,
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
            const SizedBox(
              width: 8.0,
            ),
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
