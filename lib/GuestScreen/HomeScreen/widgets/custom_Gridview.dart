import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/GuestScreen/AboutScreen/about_screen.dart';
import '../../../localString/Data/dummy_data.dart';
import '../../CareerCenterScreen/careerCenter_screen.dart';
import '../../ContactScreen/contact_screen.dart';
import '../../EventScreen/EventScreen.dart';
import '../../ProgramScreen/program_screen.dart';
import '../../RegisterScreen/register_screen.dart';
import '../../ScholarshipScreen/schorlarship_screen.dart';
import '../../VideoScreen/video_screen.dart';
import 'custom_GridItem.dart';

class CustomGridview extends StatelessWidget {
  const CustomGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: gridItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (context, index) {
          return GridItem(
            title: gridItems[index]['title']!.tr,
            iconPath: gridItems[index]['icon']!,
            onTap: () {
              final Widget page;

              switch (index) {
                case 0:
                  page = EventScreen();
                  break;
                case 1:
                  page = const RegisterScreen();
                  break;
                case 2:
                  page = const ProgramScreen();
                  break;
                case 3:
                  page = const SchorlarshipScreen();
                  break;
                case 4:
                  page = const CareerCenterScreen();
                  break;
                case 5:
                  page = const VideoScreen();
                  break;
                case 6:
                  page = const ContactScreen();
                  break;
                case 7:
                  page = const AboutScreen();
                  break;
                default:
                  page = Container();
                  break;
              }

              // Simply push the page, and the global animation will handle the transition
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          );
        },
      ),
    );
  }
}
