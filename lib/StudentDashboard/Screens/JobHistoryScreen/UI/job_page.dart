import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:useaapp_version_2/StudentDashboard/components/custom_Student_Multi_Appbar.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/theme/background.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../../../api/fetch_user.dart'; // Ensure this path is correct
import '../../../auth/model/login_model_class.dart'; // Ensure this path is correct
import '../../../helpers/shared_pref_helper.dart';
import '../widget/job_shimmer.dart'; // Ensure this path is correct

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late Future<UserDataResponse?> futureUserData;
  bool _showShimmer = true;

  @override
  void initState() {
    super.initState();
    futureUserData = _fetchUserData();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showShimmer = false;
      });
    });
  }

  Future<UserDataResponse?> _fetchUserData() async {
    String? studentId = await SharedPrefHelper.getStudentId();
    String? password = await SharedPrefHelper.getPassword();

    if (studentId != null && password != null) {
      return await loginStudent(studentId, password);
    } else {
      throw Exception('Student ID or Password not found.');
    }
  }

  String formatDate(String dateString) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateString);
    // Format it to "31 March, 2020"
    return DateFormat('dd MMMM, yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return Scaffold(
      appBar: StudentMultiAppBar(
        title: 'ប្រវត្តិការងារ'.tr,
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
          FutureBuilder<UserDataResponse?>(
            future: futureUserData,
            builder: (context, snapshot) {
              if (_showShimmer) {
                // Show shimmer for 2 seconds
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const JobShimmer();
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const JobShimmer();
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                List<JobHistoryData> jobHistory = snapshot.data!.jobHistoryData;

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: jobHistory.isNotEmpty ? jobHistory.length : 1,
                  itemBuilder: (context, index) {
                    if (jobHistory.isNotEmpty) {
                      JobHistoryData job = jobHistory[index];
                      return _buildJobCard(job);
                    } else {
                      return _buildEmptyJobCard();
                    }
                  },
                );
              } else {
                return const Center(child: Text('No data found.'));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(JobHistoryData job) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: context.bgThirdDarkMode,
          borderRadius:
              const BorderRadius.all(Radius.circular(rd_MediumRounded)),
          boxShadow: const [sd_BoxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('Date of entry:', job.dateStartWork),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextList(context, 'ស្ថានភាពការងារ'.tr,
                      job.statusName.isNotEmpty ? job.statusName : 'N/A'),
                  _buildTextList(context, 'Institutions:',
                      job.workPlace.isNotEmpty ? job.workPlace : 'N/A'),
                  _buildTextList(context, 'Position:',
                      job.position.isNotEmpty ? job.position : 'N/A'),
                  _buildTextList(context, 'Salary:',
                      job.salary.isNotEmpty ? job.salary : 'N/A'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyJobCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 300.h,
        decoration: BoxDecoration(
          color: context.bgThirdDarkMode,
          borderRadius:
              const BorderRadius.all(Radius.circular(rd_MediumRounded)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader('កាលបរិច្ឆេទចូលបម្រើការងារ​\t\t\t\t\t'.tr, 'N/A'),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextList(context, 'ស្ថានភាពការងារ'.tr, 'N/A'),
                  _buildTextList(context, 'ស្ថាប័ន'.tr, 'N/A'),
                  _buildTextList(context, 'មុខតំណែង'.tr, 'N/A'),
                  _buildTextList(context, 'ប្រាក់បៀវត្ស'.tr, 'N/A'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String label, String date) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.secondaryColoDarkMode,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(rd_MediumRounded),
          topRight: Radius.circular(rd_MediumRounded),
        ),
      ),
      child: Text(
        '$label ${date.isNotEmpty && date != 'N/A' ? formatDate(date) : 'N/A'}',
        style: getTitleSmallPrimaryColorTextStyle()
            .copyWith(color: context.titlePrimaryColor),
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
              Text(
                label,
                style: getTitleSmallPrimaryColorTextStyle().copyWith(
                  color: context.titlePrimaryColor,
                ),
              ),
              Text(
                textValue,
                style: getTitleSmallPrimaryColorTextStyle().copyWith(
                  color: context.titlePrimaryColor,
                ),
              ),
            ],
          ),
          Divider(
            color: context.secondaryColoDarkMode,
            thickness: 1,
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
