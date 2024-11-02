import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:useaapp_version_2/StudentDashboard/components/custom_Student_Multi_Appbar.dart';
import 'package:useaapp_version_2/theme/background.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../../../api/fetch_schedule.dart';
import '../../../api/util/api_endpoints.dart';
import '../../../helpers/shared_pref_helper.dart';
import '../bloc/schedule_bloc.dart';
import '../bloc/schedule_event.dart';
import '../bloc/schedule_state.dart';
import 'package:http/http.dart' as http;
import '../widget/custom_calendar.dart';
import '../widget/schedule_shimmer.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late ScheduleBloc scheduleBloc;
  DateTime selectedDate = DateTime.now();
  String? studentId;
  String? password;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    scheduleBloc = ScheduleBloc(ScheduleRepository());
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    studentId = await SharedPrefHelper.getStudentId();
    password = await SharedPrefHelper.getPassword();

    if (studentId != null && password != null) {
      _fetchScheduleForDate(selectedDate);
    }
  }

  @override
  void dispose() {
    scheduleBloc.close();
    super.dispose();
  }

  Future<void> _onDateSelected(DateTime day) async {
    setState(() {
      selectedDate = day;
    });
    await _fetchScheduleForDate(day);
  }

  Future<void> _fetchScheduleForDate(DateTime date) async {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    if (studentId != null && password != null) {
      scheduleBloc.add(LoadSchedule(studentId!, password!, formattedDate));

      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      await _fetchScheduleFromApi(formattedDate);

      // Set loading to false
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchScheduleFromApi(String formattedDate) async {
    try {
      String apiUrl = ApiEndpoints.scheduleData;
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'student_id': studentId!,
          'pwd': password!,
          'date': formattedDate,
        },
      );

      if (response.statusCode != 200) {
        print('Failed to load schedule: ${response.statusCode}');
      }
    } catch (error) {
      print("Error sending date to server: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return BlocProvider(
      create: (_) => scheduleBloc,
      child: Scaffold(
        appBar: StudentMultiAppBar(
          title: 'កាលវិភាគ'.tr,
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Stack(
          children: [
            BackgroundContainer(isDarkMode: colorMode),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomCalendar(
                          selectedDate: selectedDate,
                          onDateSelected: _onDateSelected,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'កាលវិភាគសិក្សា'.tr,
                          style: getTitleMediumTextStyle(),
                        ),
                      ),
                    ),
                    if (_isLoading)
                      SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(4, (index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(rd_MediumRounded),
                                    color: cl_ItemBackgroundColor,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: ScheduleShimmer(
                                    height: 90.0,
                                    width: double.infinity,
                                    borderRadius:
                                        BorderRadius.circular(rd_MediumRounded),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      )
                    else if (state is ScheduleLoaded)
                      _buildScheduleList(state)
                    else if (state is ScheduleError)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Text(
                              'No schedule Today.',
                              style: TextStyle(color: cl_ThirdColor),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  RenderObjectWidget _buildScheduleList(ScheduleLoaded state) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    final filteredSchedule =
        state.schedule.where((item) => item.datefull == formattedDate).toList();

    if (filteredSchedule.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 26.0.h),
          child: Center(
            child: Text(
              'No schedule for selected day.',
              style: getTitleSmallTextStyle(),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = filteredSchedule[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: context.bgThirdDarkMode,
                borderRadius: BorderRadius.circular(rd_MediumRounded),
                boxShadow: const [sd_BoxShadow],
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 18.r,
                        horizontal: 24.r,
                      ),
                      decoration: BoxDecoration(
                        color: context.secondaryColoDarkMode,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.date,
                            style: getBodyLargeTextStyle().copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.subTitleColor,
                            ),
                          ),
                          Text(
                            item.weekday,
                            style: getBodyLargeTextStyle().copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.subTitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.subject,
                            style: getTitleSmallPrimaryColorTextStyle()
                                .copyWith(color: context.titlePrimaryColor),
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.classroom,
                                    style: getBodyMediumTextStyle().copyWith(
                                      color: context.subTitleColor,
                                    ),
                                  ),
                                  Text(
                                    item.teacherName,
                                    style: getBodyMediumTextStyle().copyWith(
                                      color: context.subTitleColor,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.session,
                                    style: getBodyMediumTextStyle().copyWith(
                                      color: context.subTitleColor,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    item.tel,
                                    style: getBodyMediumTextStyle().copyWith(
                                      color: context.subTitleColor,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: filteredSchedule.length,
      ),
    );
  }
}
