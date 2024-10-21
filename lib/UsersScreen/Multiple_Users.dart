import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/StudentDashboard/auth/UI/LoginPage.dart';
import 'package:useaapp_version_2/theme/constants.dart';

import '../GuardianScreen/guardian_Screen.dart';

class MultipleUsers extends StatelessWidget {
  const MultipleUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> gridItems = [
      'គណនីនិស្សិត'.tr,
      'គណនីអាណាព្យាបាល'.tr,
    ];

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // Top image
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  'assets/img/bg_image_top.png',
                  fit: BoxFit.cover,
                ),
              ),

              // GridView in the center
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 16,
                      childAspectRatio: 12 / 2,
                    ),
                    itemCount: gridItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (gridItems[index] == 'គណនីនិស្សិត' ||
                              gridItems[index] == 'Student Account') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } else if (gridItems[index] == 'គណនីអាណាព្យាបាល' ||
                              gridItems[index] == 'Guardian Account') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GuardianScreen(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cl_ThirdColor,
                            borderRadius:
                                BorderRadius.circular(rd_MediumRounded),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                blurStyle: BlurStyle.normal,
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(0, 0),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              gridItems[index],
                              style: const TextStyle(
                                color: cl_PrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Bottom image
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Image.asset(
                  'assets/img/bg_image_bottom.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        // Back button
        Positioned(
          top: 16,
          left: 5,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: cl_PrimaryColor,
              size: 26,
            ),
            onPressed: () {
              // Navigator.pop(context);
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
