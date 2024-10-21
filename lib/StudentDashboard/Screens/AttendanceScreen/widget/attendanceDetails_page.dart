import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../model/attendance_model.dart';

class AttendanceDetailsPage extends StatelessWidget {
  final Subject subject;

  const AttendanceDetailsPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
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
          subject.name,
          style: getTitleMediumTextStyle(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0.h),
          child: Container(
            color: context.appBarColor,
            height: 40.0.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderText(context, 'កាលបរិច្ឆេទ'),
                _buildHeaderText(context, 'ម៉ោងសិក្សា'),
                _buildHeaderText(context, 'វត្តមាន\t'),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.secondaryColoDarkMode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: subject.dates.isEmpty
                      ? Center(
                          child: Text(
                            'មិនមានវត្តមានសម្រាប់មុខវិជ្ជានេះទេ។',
                            style: getTitleSmallPrimaryColorTextStyle(),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: subject.dates.length,
                          itemBuilder: (context, index) {
                            final date = subject.dates[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(left: 16.0.r),
                                          child: Text(
                                            date.dateName,
                                            style:
                                                getTitleSmallPrimaryColorTextStyle()
                                                    .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: context.subTitleColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.sp),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:
                                              date.sessions.map((session) {
                                            Color sessionColor;

                                            if (int.parse(session.session) %
                                                    2 ==
                                                0) {
                                              sessionColor =
                                                  const Color(0xFF39AEC7)
                                                      .withOpacity(0.5);
                                            } else {
                                              sessionColor =
                                                  const Color(0xFFC7396D)
                                                      .withOpacity(0.5);
                                            }

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: sessionColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            rd_SmallRounded),
                                                  ),
                                                  child: Text(
                                                    session.sessionAll,
                                                    style:
                                                        getTitleSmallTextStyle(),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(width: 16.sp),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children:
                                              date.sessions.map((session) {
                                            String statusText;
                                            Color containerColor;

                                            if (session.absentStatus == "al") {
                                              statusText = 'យឺត';
                                              containerColor =
                                                  context.attendLateMode;
                                            } else if (session.absentStatus ==
                                                "ps") {
                                              statusText = 'វត្តមាន\t';
                                              containerColor =
                                                  context.attendPresentMode;
                                            } else if (session.absentStatus ==
                                                "awop") {
                                              statusText = 'សុំច្បាប់';
                                              containerColor =
                                                  context.attendPermissionMode;
                                            } else if (session.absentStatus ==
                                                "awp") {
                                              statusText = 'អវត្តមាន';
                                              containerColor =
                                                  context.attendAbsentMode;
                                            } else {
                                              statusText = 'N/A';
                                              containerColor = Colors.grey;
                                            }

                                            return Container(
                                              width: 90.w,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 6.h,
                                              ),
                                              margin: const EdgeInsets.only(
                                                bottom: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: containerColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  rd_SmallRounded,
                                                ),
                                              ),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                statusText,
                                                style: getTitleSmallTextStyle()
                                                    .copyWith(
                                                        color:
                                                            context.titleColor),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (index < subject.dates.length - 1)
                                  const Divider(
                                    color: cl_PlaceholderColor,
                                    thickness: 0.2,
                                  ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build each header text with Expanded
  Widget _buildHeaderText(BuildContext context, String text) {
    return Expanded(
      child: Text(
        text.tr,
        textAlign: TextAlign.center,
        style: getTitleMediumTextStyle().copyWith(color: context.titleColor),
      ),
    );
  }
}
