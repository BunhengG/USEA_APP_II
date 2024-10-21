// profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/StudentDashboard/settings/settingPage.dart';
import 'package:useaapp_version_2/theme/background.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../GuestDashboard/Screen/EventScreen/widgets/custom_FullScreenImage.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    //COMMENT: Check current theme mode
    final colorMode = isDarkMode(context);

    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadUserProfile()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          titleSpacing: 5,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: context.appBarColor),
          ),
          title: Text(
            'ព័ត៌មានលម្អិតរបស់និស្សិត'.tr,
            style: getTitleMediumTextStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          leading: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: cl_ThirdColor,
              size: 22,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // Assuming this is in your ProfilePage
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage()),
                );
              },
              child: const FaIcon(
                FontAwesomeIcons.gear,
                color: cl_ThirdColor,
                size: 24,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            BackgroundContainer(isDarkMode: colorMode),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoaded) {
                    final userData = state.userData;

                    // Create a list of user detail objects
                    final userDetails = [
                      {
                        'userLabel': 'មហាវិទ្យាល័យ'.tr,
                        'userValue': userData.facultyName,
                        'imagePath': 'assets/icon/Stu_Faculty.png',
                      },
                      {
                        'userLabel': 'កម្រិតសិក្សា'.tr,
                        'userValue': userData.degreeName,
                        'imagePath': 'assets/icon/Stu_Degree.png',
                      },
                      {
                        'userLabel': 'មុខជំនាញ'.tr,
                        'userValue': userData.majorName,
                        'imagePath': 'assets/icon/Stu_Major.png',
                      },
                      {
                        'userLabel': 'បន្ទប់សិក្សា'.tr,
                        'userValue': userData.roomName,
                        'imagePath': 'assets/icon/Stu_Room.png',
                      },
                      {
                        'userLabel': 'វេនសិក្សា'.tr,
                        'userValue': userData.shiftName,
                        'imagePath': 'assets/icon/stu_shift.png',
                      },
                      {
                        'userLabel': 'ស្ថានភាពសិក្សា'.tr,
                        'userValue': userData.statusName,
                        'imagePath': 'assets/icon/Stu_Status.png',
                      },
                      {
                        'userLabel': 'ថ្ងៃកំណើត'.tr,
                        'userValue': userData.dateOfBirth,
                        'imagePath': 'assets/icon/Stu_DOB.png',
                      },
                      {
                        'userLabel': 'លេខទូរស័ព្ទ'.tr,
                        'userValue': userData.phoneNumber,
                        'imagePath': 'assets/icon/Stu_Tel.png',
                      },
                      {
                        'userLabel': 'មុខតំណែង'.tr,
                        'userValue': userData.job,
                        'imagePath': 'assets/icon/Stu_Job.png',
                      },
                      {
                        'userLabel': 'ស្ថាប័ន'.tr,
                        'userValue': userData.workPlace,
                        'imagePath': 'assets/icon/Stu_Workplace.png',
                      },
                    ];

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Check if the profile picture is not empty and not the placeholder image
                              if (userData.profilePic.isNotEmpty &&
                                  userData.profilePic !=
                                      'http://116.212.155.149:9999/usea/studentsimg/noimage.png') {
                                // Navigate to the full-screen image view
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                      imagePath: userData.profilePic,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: context.bgIconColor,
                                  width: 5,
                                ),
                              ),
                              child: ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 487 / 451,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        alignment: FractionalOffset.topCenter,
                                        image: (userData
                                                    .profilePic.isNotEmpty &&
                                                userData.profilePic !=
                                                    'http://116.212.155.149:9999/usea/studentsimg/noimage.png')
                                            ? NetworkImage(userData.profilePic)
                                            : const AssetImage(
                                                'assets/img/avator_palceholder.png',
                                              ) as ImageProvider,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                          Text(
                            userData.nameKh,
                            style: getTitleKhmerMoolPrimaryColorTextStyle()
                                .copyWith(
                              color: context.titleColor,
                              fontSize: 24.sp,
                            ),
                          ),
                          Text(
                            ' @ID: ${userData.studentId}',
                            style: TextStyle(
                              fontSize: 16,
                              color: context.titleColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: ft_Eng,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Study Details Container using ListView.builder
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: context.bgThirdDarkMode,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                final studyDetails = [
                                  {
                                    'studyLabel': 'ឆ្នាំ'.tr,
                                    'studyValue': userData.yearName,
                                    'imagePath': 'assets/icon/year.png',
                                  },
                                  {
                                    'studyLabel': 'ឆមាស'.tr,
                                    'studyValue': userData.semesterName,
                                    'imagePath': 'assets/icon/semester.png',
                                  },
                                  {
                                    'studyLabel': 'ជំនាន់'.tr,
                                    'studyValue': userData.stageName,
                                    'imagePath': 'assets/icon/stage.png',
                                  },
                                  {
                                    'studyLabel': 'វគ្គ'.tr,
                                    'studyValue': userData.termName,
                                    'imagePath': 'assets/icon/term.png',
                                  },
                                  {
                                    'studyLabel': 'ឆ្នាំសិក្សា'.tr,
                                    'studyValue': userData.academicYear,
                                    'imagePath': 'assets/icon/academic.png',
                                  },
                                ];

                                final studyDetail = studyDetails[index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailRow(
                                      context,
                                      studyDetail['studyLabel'] ?? 'Unknown',
                                      studyDetail['studyValue'] ?? 'N/A',
                                      studyDetail['imagePath'] ??
                                          'assets/images/default.png',
                                    ),
                                    if (index < 4)
                                      Divider(
                                        color: context.secondaryColoDarkMode,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),

                          // User Details Container
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: context.bgThirdDarkMode,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: userDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                final detail = userDetails[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildListDetailRow(
                                      context,
                                      detail['userLabel'] ?? 'Unknown',
                                      detail['userValue'] ?? 'N/A',
                                      detail['imagePath'] ??
                                          'assets/images/default.png',
                                    ),
                                    if (index < userDetails.length - 1)
                                      Divider(
                                        color: context.secondaryColoDarkMode,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('No Data Found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each detail row with Image asset
  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: context.bgIconColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          imagePath,
                          width: 18.0,
                          height: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    label,
                    style: getTitleSmallPrimaryColorTextStyle().copyWith(
                      fontSize: 16.sp,
                      color: context.titlePrimaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: getTitleSmallPrimaryColorTextStyle().copyWith(
                  fontSize: 16.sp,
                  color: context.titlePrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build each detail row
  Widget _buildListDetailRow(
      BuildContext context, String label, String value, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.bgIconColor),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  imagePath,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Container(
            padding: const EdgeInsets.all(4.0),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: getTitleMediumPrimaryColorTextStyle().copyWith(
                    color: context.titlePrimaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: getBodyLargeTextStyle().copyWith(
                    fontSize: 13.sp,
                    color: context.subTitleColor,
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
