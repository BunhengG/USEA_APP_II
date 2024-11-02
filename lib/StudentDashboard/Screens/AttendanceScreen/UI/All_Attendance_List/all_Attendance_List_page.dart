import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:useaapp_version_2/StudentDashboard/components/custom_Student_Multi_Appbar.dart';
import 'package:useaapp_version_2/theme/background.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../../theme/constants.dart';
import '../../../../../theme/text_style.dart';
import '../../../../../theme/theme_provider/theme_utils.dart';
import '../../model/attendance_model.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../../widget/attendanceDetails_page.dart';
import '../../widget/attendance_shimmer_list.dart';
import 'bloc/all_attendance_list_bloc.dart';
import 'bloc/all_attendance_list_event.dart';
import 'bloc/all_attendance_list_state.dart';

class CheckAllAttendancePage extends StatelessWidget {
  final List<Attendances> attendances;

  const CheckAllAttendancePage({super.key, required this.attendances});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceListBloc()..add(FetchAttendanceList(attendances)),
      child: _CheckAllAttendanceView(),
    );
  }
}

class _CheckAllAttendanceView extends StatefulWidget {
  @override
  __CheckAllAttendanceViewState createState() =>
      __CheckAllAttendanceViewState();
}

class __CheckAllAttendanceViewState extends State<_CheckAllAttendanceView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = (result != ConnectivityResult.none);
    });

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = (result != ConnectivityResult.none);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return Scaffold(
      appBar: StudentMultiAppBar(
        title: 'មើលទាំងអស់'.tr,
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: _isConnected
          ? _buildAllAttendanceContent(context, colorMode)
          : _buildNoInternetUI(context, colorMode),
    );
  }

  Widget _buildAllAttendanceContent(BuildContext context, bool colorMode) {
    return Stack(
      children: [
        BackgroundContainer(isDarkMode: colorMode),
        BlocBuilder<AttendanceListBloc, AttendanceListState>(
          builder: (context, state) {
            if (state is AttendanceListLoading) {
              return const Center(child: AttendanceListShimmer());
            } else if (state is AttendanceListError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is AttendanceListLoaded) {
              if (_isLoading) {
                //NOTE: Delay for 1 seconds before showing the data
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _isLoading = false;
                  });
                });
                return const Center(child: AttendanceListShimmer());
              }

              final loadedAttendances = state.attendances;

              // Set up the TabController based on the number of attendances.
              _tabController =
                  TabController(length: loadedAttendances.length, vsync: this);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildTabBar(loadedAttendances),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: loadedAttendances.map((attendance) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildTabView(
                                      "យឺត".tr,
                                      Icons.circle,
                                      const Color(0xFF003EDD),
                                    ),
                                    _buildTabView(
                                      "សុំច្បាប់".tr,
                                      Icons.circle,
                                      const Color(0xFFEA6930),
                                    ),
                                    _buildTabView(
                                      "អវត្តមាន".tr,
                                      Icons.circle,
                                      const Color(0xFEC61B12),
                                    ),
                                    _buildTabView(
                                      "វត្តមាន".tr,
                                      Icons.circle,
                                      const Color(0xFE4DC739),
                                    ),
                                  ],
                                ),
                              ),
                              _buildSemesterView(attendance),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('No attendance data found'));
          },
        ),
      ],
    );
  }

  Widget _buildNoInternetUI(BuildContext context, bool colorMode) {
    return Stack(
      children: [
        BackgroundContainer(isDarkMode: colorMode),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/icon/no_internet_icon.json',
                width: 160,
              ),
              Text(
                'គ្មានការតភ្ជាប់អ៊ីនធឺណិត...'.tr,
                style: getTitleSmallTextStyle(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildTabBar(List<Attendances> attendances) {
    return ButtonsTabBar(
      buttonMargin: const EdgeInsets.only(
        left: 16,
        top: 4,
        bottom: 4,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      controller: _tabController,
      backgroundColor: context.secondaryForTabBarColoDarkMode,
      borderColor: cl_ThirdColor,
      borderWidth: 1.2,
      unselectedBackgroundColor: context.colorDarkMode,
      unselectedLabelStyle: const TextStyle(
        color: cl_ItemBackgroundColor,
        fontWeight: FontWeight.bold,
      ),
      labelStyle: const TextStyle(
        color: cl_ThirdColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      contentCenter: true,
      unselectedBorderColor: cl_ItemBackgroundColor,
      radius: 8,
      height: 60.h,
      width: 140.w,
      tabs: [
        for (int i = 0; i < attendances.length; i++)
          Tab(text: 'ឆ្នាំទី​ '.tr + attendances[i].yearNo),
      ],
    );
  }

  Widget _buildSemesterView(Attendances attendance) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildSemesterCard(attendance, '1'),
          const SizedBox(height: 16),
          _buildSemesterCard(attendance, '2'),
        ],
      ),
    );
  }

  Widget _buildSemesterCard(Attendances attendance, String semesterNo) {
    final semester = attendance.semesters.firstWhere(
      (s) => s.semesterNo == semesterNo,
      orElse: () => Semester(semesterNo: semesterNo, subjects: []),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ឆមាសទី $semesterNo'.tr,
            style: getTitleMediumTextStyle(),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: semester.subjects.length,
          itemBuilder: (context, index) {
            final subject = semester.subjects[index];
            return InkWell(
              borderRadius: BorderRadius.circular(rd_MediumRounded),
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rd_MediumRounded),
                  color: context.secondaryColoDarkMode,
                  boxShadow: const [sd_BoxShadow],
                ),
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subject.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: getTitleMediumPrimaryColorTextStyle()
                                  .copyWith(
                                color: context.titlePrimaryColor,
                              ),
                            ),
                            Text(
                              '${subject.credit}${'\tក្រេឌីត\t'.tr}${subject.hour}${'\tម៉ោង'.tr}',
                              style: getBodyMediumTextStyle().copyWith(
                                color: context.subTitleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            _buildGridItem(subject.attendanceA,
                                valueColor: const Color(0xFFC61B12)),
                            _buildGridItem(subject.attendancePm,
                                valueColor: const Color(0xFFEA6930)),
                            _buildGridItem(subject.attendanceAl,
                                valueColor: const Color(0xFF003EDD)),
                            _buildGridItem(subject.attendancePs,
                                valueColor: const Color(0xFF4DC739)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTabView(String title, IconData icon, Color color) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 18.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          title,
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
        borderRadius: BorderRadius.circular(rd_SmallRounded),
        color: context.colorCountAttendDarkMode,
      ),
      margin: EdgeInsets.all(2.0.sp),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            value.toString(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ),
      ),
    );
  }
}
