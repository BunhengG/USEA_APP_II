import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/StudentDashboard/components/custom_Student_Multi_Appbar.dart';
import 'package:useaapp_version_2/theme/text_style.dart';
import 'package:useaapp_version_2/utils/background.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';

import '../../../../theme/constants.dart';
import '../../../../utils/theme_provider/theme_utils.dart';
import '../../../api/fetch_studyInfo.dart';
import '../../../helpers/shared_pref_helper.dart';
import '../model/studyInfo_model.dart';
import '../widget/study_shimmer.dart';

class StudyInfoPage extends StatefulWidget {
  const StudyInfoPage({super.key});

  @override
  State<StudyInfoPage> createState() => _StudyInfoPageState();
}

class _StudyInfoPageState extends State<StudyInfoPage> {
  late Future<List<StudyInfo>> futureStudyInfo;
  bool _showShimmer = true;

  @override
  void initState() {
    super.initState();
    futureStudyInfo = _fetchData();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showShimmer = false;
      });
    });
  }

  Future<List<StudyInfo>> _fetchData() async {
    String? studentId = await SharedPrefHelper.getStudentId();
    String? password = await SharedPrefHelper.getPassword();

    if (studentId != null && password != null) {
      return await fetchStudyInfoData(studentId, password);
    } else {
      throw Exception('Student ID or Password not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return Scaffold(
      appBar: StudentMultiAppBar(
        title: 'ព័ត៌មានការសិក្សា'.tr,
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: [
          // Container(
          //   decoration: const BoxDecoration(gradient: u_BackgroundScaffold),
          // ),
          BackgroundContainer(isDarkMode: colorMode),
          FutureBuilder<List<StudyInfo>>(
            future: futureStudyInfo,
            builder: (context, snapshot) {
              if (_showShimmer) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const StudyShimmer();
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const StudyShimmer();
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return _buildStudyInfoList(snapshot.data!);
              } else {
                return const Center(child: Text('No data found.'));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudyInfoList(List<StudyInfo> studyInfoList) {
    // Show study info if available, otherwise show an empty card
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: studyInfoList.isNotEmpty ? studyInfoList.length : 1,
      itemBuilder: (context, index) {
        if (studyInfoList.isNotEmpty) {
          // Build actual study info card if data exists
          return _buildStudyInfoCard(studyInfoList[index]);
        } else {
          // Build an empty card if no data exists
          return _buildEmptyStudyInfoCard();
        }
      },
    );
  }

  Widget _buildStudyInfoCard(StudyInfo studyInfo) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgThirdDarkMode,
        borderRadius: const BorderRadius.all(Radius.circular(rd_MediumRounded)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(context, studyInfo.title),
          const SizedBox(height: 4),
          _buildCardDetails(studyInfo),
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.secondaryColoDarkMode,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Text(
        title,
        style: getTitleSmallPrimaryColorTextStyle().copyWith(
          color: context.titlePrimaryColor,
        ),
      ),
    );
  }

  Widget _buildCardDetails(StudyInfo studyInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextList(context, 'មុខវិជ្ជា\t'.tr, studyInfo.subject),
          _buildTextList(context, 'ថ្ងៃផុតកំណត '.tr,
              '${studyInfo.date} ${studyInfo.month}'),
          _buildTextList(context, 'ម៉ោង '.tr, studyInfo.time),
          _buildTextList(context, 'បន្ទប់'.tr, studyInfo.room),
          _buildTextList(context, 'លេខតុ\t'.tr, studyInfo.seat),
        ],
      ),
    );
  }

  Widget _buildTextList(BuildContext context, String label, String textValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: getBodyLargeTextStyle()
                      .copyWith(color: context.subTitleColor),
                ),
              ),
              Text(
                textValue,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: getBodyMediumTextStyle()
                    .copyWith(color: context.subTitleColor),
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStudyInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 340.h,
        decoration: BoxDecoration(
          color: context.bgThirdDarkMode,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(context, 'មិនទាន់មានការប្រឡងនោះទេ!'),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextList(context, 'មុខវិជ្ជា\t'.tr, 'N/A'),
                  _buildTextList(context, 'ថ្ងៃផុតកំណត '.tr, 'N/A'),
                  _buildTextList(context, 'ម៉ោង '.tr, 'N/A'),
                  _buildTextList(context, 'បន្ទប់'.tr, 'N/A'),
                  _buildTextList(context, 'លេខតុ\t'.tr, 'N/A'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
