import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/GuestScreen/components/multi_Appbar.dart';
import 'package:useaapp_version_2/theme/constants.dart';

import '../models/acca_Models.dart';

class AccaDetailsScreen extends StatelessWidget {
  final List<Subject_Data> subjectData;

  const AccaDetailsScreen({super.key, required this.subjectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: 'ACCA',
        onBackButtonPressed: () {
          Get.back();
        },
      ),
      body: subjectData.isEmpty
          ? const Center(child: Text('No subjects available'))
          : Stack(
              children: [
                Container(
                  decoration:
                      const BoxDecoration(gradient: u_BackgroundScaffold),
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subjectData.length,
                  itemBuilder: (context, index) {
                    final subject = subjectData[index];
                    return Container(
                      decoration: const BoxDecoration(
                        color: cl_ThirdColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(rd_MediumRounded),
                        ),
                        boxShadow: [sd_BoxShadow],
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(rd_MediumRounded),
                                topRight: Radius.circular(rd_MediumRounded),
                              ),
                              color: cl_SecondaryColor,
                            ),
                            padding: const EdgeInsets.all(18),
                            child: Text(
                              subject.subject,
                              style: const TextStyle(
                                fontSize: 14,
                                color: cl_PrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Hours per week:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: ft_Eng,
                                        fontWeight: FontWeight.w500,
                                        color: cl_TextColor,
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 221, 221, 221),
                                      ),
                                      child: Center(
                                        child: Text(
                                          subject.hour_per_week,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: ft_Eng,
                                            fontWeight: FontWeight.w400,
                                            color: cl_TextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 0.5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Weeks:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: ft_Eng,
                                        fontWeight: FontWeight.w500,
                                        color: cl_TextColor,
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 221, 221, 221),
                                      ),
                                      child: Center(
                                        child: Text(
                                          subject.weeks,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: ft_Eng,
                                            fontWeight: FontWeight.w400,
                                            color: cl_TextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 0.5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total hours:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: ft_Eng,
                                        fontWeight: FontWeight.w500,
                                        color: cl_TextColor,
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 221, 221, 221),
                                      ),
                                      child: Center(
                                        child: Text(
                                          subject.total_hour,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: ft_Eng,
                                            fontWeight: FontWeight.w400,
                                            color: cl_TextColor,
                                          ),
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
                ),
              ],
            ),
    );
  }
}
