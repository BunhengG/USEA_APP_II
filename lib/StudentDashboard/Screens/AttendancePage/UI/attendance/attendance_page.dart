import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/utils/background.dart';
import 'package:useaapp_version_2/utils/color_builder.dart';
import '../../../../../GuestScreen/components/circularProgressIndicator.dart';
import '../../../../../theme/constants.dart';
import '../../../../../theme/text_style.dart';
import '../../../../../utils/theme_provider/theme_utils.dart';
import '../../../../auth/model/login_model_class.dart';
import '../../../../helpers/shared_pref_helper.dart';
import '../../model/attendance_model.dart';
import '../../widget/attendance_shimmer.dart';
import '../All_Attendance_List/all_Attendance_List_page.dart';
import '../../widget/attendanceDetails_page.dart';
import 'bloc/attendance_bloc.dart';
import 'bloc/attendance_event.dart';
import 'bloc/attendance_state.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getStudentCredentials(),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicatorWidget()),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Error retrieving credentials')),
          );
        } else {
          final credentials = snapshot.data!;
          return BlocProvider(
            create: (context) => AttendanceBloc()
              ..add(FetchAttendance(
                credentials['studentId']!,
                credentials['password']!,
              )),
            child: const AttendanceView(),
          );
        }
      },
    );
  }

  // Helper method to fetch the student ID and password asynchronously
  Future<Map<String, String>> _getStudentCredentials() async {
    String? studentId = await SharedPrefHelper.getStudentId();
    String? password = await SharedPrefHelper.getPassword();

    if (studentId == null || password == null) {
      throw Exception("No student ID or password found.");
    }

    return {
      'studentId': studentId,
      'password': password,
    };
  }
}

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  UserData? userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize and load the user data
  void _initializeData() async {
    userData = await SharedPrefHelper.getStoredUserData();
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        titleSpacing: 5,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: context.appBarColor),
        ),
        title: Text(
          'វត្តមាន'.tr,
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
        actions: [
          TextButton(
            onPressed: () {
              final attendanceState =
                  BlocProvider.of<AttendanceBloc>(context).state;
              if (attendanceState is AttendanceLoaded) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckAllAttendancePage(
                      attendances: attendanceState.attendances,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No attendance data available.'),
                  ),
                );
              }
            },
            child: Text(
              'មើលទាំងអស់'.tr,
              style: getTitleMediumTextStyle(),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     gradient: u_BackgroundScaffold,
          //   ),
          // ),
          BackgroundContainer(isDarkMode: colorMode),
          BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              if (state is AttendanceLoading) {
                return const AttendanceShimmer(
                  height: 40,
                  width: double.infinity,
                );
              } else if (state is AttendanceError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is AttendanceLoaded) {
                if (_isLoading) {
                  //NOTE: Delay for 1 seconds before showing the data
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                  return const Center(
                    child: AttendanceShimmer(
                      height: 40,
                      width: double.infinity,
                    ),
                  );
                }

                final attendances = state.attendances;
                final filteredSubjects = _filterSubjects(attendances);

                if (filteredSubjects.isEmpty) {
                  return const Center(
                    child: Text(
                        'No subjects found for current year and semester.'),
                  );
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTabView(
                              "យឺត",
                              Icons.circle,
                              const Color(0xFF003EDD),
                            ),
                            _buildTabView(
                              "សុំច្បាប់",
                              Icons.circle,
                              const Color(0xFFEA6930),
                            ),
                            _buildTabView(
                              "អវត្តមាន",
                              Icons.circle,
                              const Color(0xFEC61B12),
                            ),
                            _buildTabView(
                              "វត្តមាន\t",
                              Icons.circle,
                              const Color(0xFE4DC739),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = filteredSubjects[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AttendanceDetailsPage(subject: subject),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: context.listViewDarkMode,
                                  boxShadow: const [sd_BoxShadow],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              subject.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  getTitleMediumPrimaryColorTextStyle()
                                                      .copyWith(
                                                color:
                                                    context.titlePrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              '${subject.credit}${'\tក្រេឌីត\t'.tr}${subject.hour}${'\tម៉ោង'.tr}',
                                              style: getBodyMediumTextStyle()
                                                  .copyWith(
                                                color: context.textDecColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: [
                                            _buildGridItem(subject.attendanceA,
                                                valueColor:
                                                    const Color(0xFFC61B12)),
                                            _buildGridItem(subject.attendancePm,
                                                valueColor:
                                                    const Color(0xFFEA6930)),
                                            _buildGridItem(subject.attendanceAl,
                                                valueColor:
                                                    const Color(0xFF003EDD)),
                                            _buildGridItem(subject.attendancePs,
                                                valueColor:
                                                    const Color(0xFF4DC739)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('No attendance data found'));
            },
          ),
        ],
      ),
    );
  }

  List<Subject> _filterSubjects(List<Attendances> attendances) {
    if (userData == null) return [];

    String currentYear = userData!.yearName;
    String currentSemester = userData!.semesterName;

    List<Subject> filteredSubjects = [];

    for (var attendance in attendances) {
      if (attendance.yearNo == currentYear) {
        for (var semester in attendance.semesters) {
          if (semester.semesterNo == currentSemester) {
            filteredSubjects.addAll(semester.subjects);
          }
        }
      }
    }

    return filteredSubjects;
  }

  Widget _buildTabView(String title, IconData icon, Color color) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          title.tr,
          style: getBodyMediumThirdColorTextStyle(),
        ),
      ],
    );
  }

  Widget _buildGridItem(int value, {Color? valueColor}) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorCountAttendDarkMode,
      ),
      margin: const EdgeInsets.all(2.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ),
      ),
    );
  }
}
