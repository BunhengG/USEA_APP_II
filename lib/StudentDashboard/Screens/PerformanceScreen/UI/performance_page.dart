import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:useaapp_version_2/StudentDashboard/components/custom_Student_Multi_Appbar.dart';
import 'package:useaapp_version_2/theme/background.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_provider.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../../../helpers/convert_numbers_roman.dart';
import '../bloc/performance_bloc.dart';
import '../bloc/performance_event.dart';
import '../bloc/performance_state.dart';
import '../model/performance_model.dart';
import '../widget/attend_bottom_sheet.dart';
import '../widget/shimmer_Performance.dart';
import '../widget/scores_bottom_sheet.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PerformanceBloc()..add(FetchPerformanceData()),
      child: const PerformanceView(),
    );
  }
}

class PerformanceView extends StatefulWidget {
  const PerformanceView({super.key});

  @override
  _PerformanceViewState createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isLoading = true;
  bool _isConnected = true;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
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
      backgroundColor: Colors.white,
      //COMMENT: ******************************** AppBar ********************************
      appBar: StudentMultiAppBar(
        title: 'ដំណើរការសិក្សា'.tr,
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: _isConnected
          ? _buildPerformanceContent(context, colorMode)
          : _buildNoInternetUI(context, colorMode),
    );
  }

  Widget _buildPerformanceContent(BuildContext context, bool colorMode) {
    return Stack(
      children: [
        BackgroundContainer(isDarkMode: colorMode),
        BlocBuilder<PerformanceBloc, PerformanceState>(
          builder: (context, state) {
            if (state is PerformanceLoading) {
              return const Center(child: CustomShimmerPerformancePage());
            } else if (state is PerformanceError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon/empty.png',
                      width: 120.w,
                    ),
                    Text(
                      'Something went wrong. We will back soon.',
                      style: getTitleSmallTextStyle().copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PerformanceLoaded) {
              if (_isLoading) {
                //NOTE: Delay for 1 seconds before showing the data
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _isLoading = false;
                  });
                });
                return const Center(child: CustomShimmerPerformancePage());
              }

              final data = state.performances;
              _tabController ??= TabController(
                length: data.length,
                vsync: this,
              );

              return Column(
                children: [
                  SizedBox(height: 16.r),
                  //COMMENT: ******************************** TabBar Header ********************************
                  ButtonsTabBar(
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
                    labelStyle: const TextStyle(
                      color: cl_ThirdColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    contentCenter: true,
                    unselectedLabelStyle: const TextStyle(
                      color: cl_ItemBackgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedBorderColor: cl_ItemBackgroundColor,
                    radius: 8,
                    height: 60.h,
                    width: 140.w,
                    tabs: [
                      for (int i = 0; i < data.length; i++)
                        Tab(text: 'ឆ្នាំទី​ '.tr + intToRoman(i + 1)),
                    ],
                  ),
                  SizedBox(height: 8.r),
                  //COMMENT: ******************************** TabBar Content ********************************
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        for (int i = 0; i < data.length; i++)
                          _buildYearTab(data[i]),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icon/empty.png',
                    width: 120.w,
                  ),
                  Text(
                    'No Data.',
                    style: getTitleSmallTextStyle().copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            );
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

  //COMMENT: ******************************** Semesters Cards ********************************
  Widget _buildYearTab(PerformanceClass yearData) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (yearData.semesters.isNotEmpty)
          _buildSemesterSection(context, 'ឆមាសទី ១'.tr, yearData.semesters[0]),
        const SizedBox(height: 16),
        if (yearData.semesters.length > 1)
          _buildSemesterSection(context, 'ឆមាសទី ២'.tr, yearData.semesters[1]),
        SizedBox(height: 16.h),
      ],
    );
  }

  //COMMENT: ******************************** Cards Content ********************************
  Widget _buildSemesterSection(
    BuildContext context,
    String semesterTitle,
    Semester semester,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgThirdDarkMode,
        borderRadius: const BorderRadius.all(Radius.circular(rd_MediumRounded)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //COMMENT: ******************************** Header ********************************
          Container(
            padding: EdgeInsets.all(8.r),
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.secondaryColoDarkMode,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(rd_MediumRounded),
                topRight: Radius.circular(rd_MediumRounded),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      semesterTitle,
                      style: getTitleSmallPrimaryColorTextStyle()
                          .copyWith(color: context.titlePrimaryColor),
                    ),
                  ),
                  Text(
                    'វត្តមាន'.tr,
                    style: getTitleSmallPrimaryColorTextStyle()
                        .copyWith(color: context.titlePrimaryColor),
                  ),
                  SizedBox(width: 44.w),
                  Text(
                    'ពិន្ទុ'.tr,
                    style: getTitleSmallPrimaryColorTextStyle()
                        .copyWith(color: context.titlePrimaryColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //COMMENT: ******************************** Body ********************************
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: semester.subjects.map((subject) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        subject.name,
                        style: getBodyMediumTextStyle().copyWith(
                          fontSize: 13.sp,
                          color: context.cardTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (subject.attendances.isNotEmpty) {
                          final backgroundColor =
                              context.read<ThemeProvider>().themeMode ==
                                      ThemeMode.dark
                                  ? cl_Background_Modal_Mode
                                  : cl_ThirdColor;
                          showAttendanceBottomSheet(
                            context,
                            subject.attendances[0],
                            subject.name,
                            backgroundColor: backgroundColor,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0.w,
                              color: subject.attendances.isNotEmpty
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        child: Text(
                          subject.attendances.isNotEmpty
                              ? subject.attendances[0].attendanceAll
                              : 'N/A',
                          style: getBodyMediumTextStyle().copyWith(
                            color: subject.attendances.isNotEmpty
                                ? const Color(0xFF4DC739)
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    InkWell(
                      onTap: () {
                        final backgroundColor =
                            context.read<ThemeProvider>().themeMode ==
                                    ThemeMode.dark
                                ? cl_Background_Modal_Mode
                                : cl_ThirdColor;
                        showScoresBottomSheet(
                          context,
                          subject.scores,
                          subject.name,
                          backgroundColor: backgroundColor,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0.w,
                              color: subject.attendances.isNotEmpty
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        child: Text(
                          subject.pscoreTotal,
                          style: getBodyMediumTextStyle().copyWith(
                            color: subject.attendances.isNotEmpty
                                ? const Color(0xFF3961C7)
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          //COMMENT: ******************************** Footer ********************************
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                  color: context.secondaryColoDarkMode,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(rd_MediumRounded)),
                  boxShadow: [
                    BoxShadow(
                      color: context.secondaryColoDarkMode.withOpacity(0.05),
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: context.secondaryColoDarkMode.withOpacity(0.4),
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: context.secondaryColoDarkMode.withOpacity(0.7),
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'មធ្យមភាគ'.tr,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                      Text(
                        'ពិន្ទុមធ្យមភាគ'.tr,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                      Text(
                        'និទ្ទេស'.tr,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        semester.average,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                      Text(
                        semester.gpa,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                      Text(
                        semester.grade,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
