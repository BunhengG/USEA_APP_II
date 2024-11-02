import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../components/multi_Appbar.dart';

class DetailsScreen extends StatefulWidget {
  final String title;
  final List<dynamic> degreeDetails;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.degreeDetails,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<String, dynamic>? selectedDegree;

  @override
  void initState() {
    super.initState();
    if (widget.degreeDetails.isNotEmpty) {
      selectedDegree = widget.degreeDetails.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MultiAppBar(
        title: widget.title,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: u_BackgroundScaffold,
            ),
          ),
          Column(
            children: [
              // Row of buttons for each degree
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.degreeDetails.map(
                  (degree) {
                    final isActive = selectedDegree == degree;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            isActive ? cl_ThirdColor : cl_ItemBackgroundColor,
                        backgroundColor: isActive
                            ? cl_ItemBackgroundColor
                            : cl_ItemBackgroundColor,
                        side: BorderSide(
                          color:
                              isActive ? cl_ThirdColor : cl_ItemBackgroundColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(rd_SmallRounded),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20.0,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedDegree = degree;
                        });
                      },
                      child: Text(
                        degree['degree_name'],
                        style: getTitleDegreeTextStyle(),
                      ),
                    );
                  },
                ).toList(),
              ),

              // Display the major info
              if (selectedDegree != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    selectedDegree!['degree_detail']['major_info'] ??
                        "No Data Available",
                    style: getBodyMediumThirdColorTextStyle().copyWith(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Divider(
                        thickness: 1,
                        color: cl_ItemBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded section to display the degree details
              Expanded(
                child: selectedDegree != null
                    ? _buildDegreeDetails(selectedDegree!)
                    : const Center(child: Text("No Data Available")),
              ),
            ],
          ),
        ],
      ),
    );
  }

//! ====================== _buildDegreeDetails

  Widget _buildDegreeDetails(Map<String, dynamic> degree) {
    if (degree.isEmpty) return const Center(child: Text("No Data Available"));

    final degreeDetail = degree['degree_detail'] ?? {};
    final degreeData = degreeDetail['degree_data'] as List;

    // Define a list of colors
    final List<Color> colors = [
      const Color(0xFFE4AC3F),
      const Color(0xFF39AEC7),
      Colors.red,
      Colors.indigo,
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(14.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 2.2 / 2,
      ),
      itemCount: degreeData.length,
      itemBuilder: (context, index) {
        final data = degreeData[index];
        final yearName = data['year_name'];
        final color = colors[index % colors.length];

        return GestureDetector(
          onTap: () {
            _showYearDetailsBottomSheet(data, color);
          },
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(rd_MediumRounded),
                    topLeft: Radius.circular(rd_MediumRounded),
                  ),
                  boxShadow: const [sd_BoxShadow],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: cl_ThirdColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(rd_LargeRounded),
                      bottomLeft: Radius.circular(rd_LargeRounded),
                    ),
                    boxShadow: [sd_BoxShadow],
                  ),
                  child: Center(
                    child: Text(
                      yearName,
                      textAlign: TextAlign.center,
                      style: getTitleSmallTextStyle().copyWith(
                        color: color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//! =================================================================

  void _showYearDetailsBottomSheet(
    Map<String, dynamic> yearData,
    Color color,
  ) {
    final totalCredit = yearData['year_data'].first['total_credit'] ?? '0';
    final subjectData = yearData['year_data'].first['subject_data'] as List;

    final ScrollController scrollController = ScrollController();

    showModalBottomSheet(
      elevation: 1.0,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5.h,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rd_LargeRounded),
                    color: color.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rd_LargeRounded),
                  color: cl_ThirdColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(rd_LargeRounded),
                          topRight: Radius.circular(rd_LargeRounded),
                        ),
                        color: color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                'មុខវិជ្ជា\t'.tr.toUpperCase(),
                                style: getTitleSmallTextStyle(),
                              ),
                            ),
                            SdW_SizeBox_M,
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Text(
                                    '\tក្រេឌីតសរុប\t'.tr.toUpperCase(),
                                    style: getTitleSmallTextStyle(),
                                  ),
                                  SdW_SizeBox_S,
                                  Container(
                                    width: 26,
                                    height: 26,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(rd_FullRounded),
                                      color: cl_ItemBackgroundColor,
                                    ),
                                    child: Text(
                                      totalCredit,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: cl_PrimaryColor,
                                        fontFamily: ft_Eng,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: RawScrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        thickness: 4.0,
                        radius: const Radius.circular(rd_SmallRounded),
                        thumbColor: cl_PlaceholderColor,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: subjectData.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final subject = subjectData[index];
                            final subjectName = subject['Subject'];
                            final credit = subject['Credit'];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${index + 1}.",
                                      style: getBodyMediumTextStyle(),
                                    ),
                                  ),
                                  SdW_SizeBox_S,
                                  Expanded(
                                    child: Text(
                                      subjectName,
                                      style: getBodyMediumTextStyle(),
                                    ),
                                  ),
                                  SdW_SizeBox_S,
                                  Container(
                                    width: 26,
                                    height: 26,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(rd_FullRounded),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Text(
                                      "$credit",
                                      style: getBodyMediumTextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
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

  //! ================================================================= _showYearDetailsBottomSheet
}
