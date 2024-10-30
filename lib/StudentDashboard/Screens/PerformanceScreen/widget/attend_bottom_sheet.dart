import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';
import '../../../../theme/text_style.dart';
import '../../../../theme/theme_provider/theme_utils.dart';
import '../model/performance_model.dart';

// Method to build the BottomSheet for Attendance data
void showAttendanceBottomSheet(
    BuildContext context, Attendances attendance, String subjectName,
    {required Color backgroundColor}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (context) {
      return AttendanceBottomSheet(
          attendance: attendance, subjectName: subjectName);
    },
  );
}

class AttendanceBottomSheet extends StatefulWidget {
  final Attendances attendance;
  final String subjectName;

  const AttendanceBottomSheet({
    super.key,
    required this.attendance,
    required this.subjectName,
  });

  @override
  _AttendanceBottomSheetState createState() => _AttendanceBottomSheetState();
}

class _AttendanceBottomSheetState extends State<AttendanceBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the height animation
    _heightAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return SizedBox(
          width: double.infinity,
          height:
              MediaQuery.of(context).size.height * 0.4 * _heightAnimation.value,
          child: SingleChildScrollView(
            // Add this line
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle centered
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 46,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        widget.subjectName,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                    ],
                  ),
                ),
                _buildDivider(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 26.0,
                    horizontal: 26,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.attendance.title,
                        style: getTitleSmallPrimaryColorTextStyle()
                            .copyWith(color: context.titlePrimaryColor),
                      ),
                      SizedBox(height: 20.sp),
                      buildAttendanceRow(
                        context,
                        'អវត្តមាន'.tr,
                        widget.attendance.attendanceA,
                        valueColor: Colors.red,
                      ),
                      _buildDivider(context),
                      SizedBox(height: 18.sp),
                      buildAttendanceRow(
                        context,
                        'សុំច្បាប់'.tr,
                        widget.attendance.attendancePm,
                        valueColor: Colors.orange,
                      ),
                      _buildDivider(context),
                      SizedBox(height: 18.sp),
                      buildAttendanceRow(
                        context,
                        'យឺត'.tr,
                        widget.attendance.attendanceAl,
                        valueColor: Colors.blue,
                      ),
                      _buildDivider(context),
                      SizedBox(height: 18.sp),
                      buildAttendanceRow(
                        context,
                        'វត្តមាន\t'.tr,
                        widget.attendance.attendancePs,
                        valueColor:
                            colorMode ? Colors.blue[700] : Colors.blue[900],
                      ),
                      _buildDivider(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildDivider(BuildContext context) {
  return Divider(
    height: 1.5,
    color: context.secondaryColoDarkMode,
  );
}

// Function to create a row for attendance details
Widget buildAttendanceRow(BuildContext context, String label, String value,
    {Color? valueColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: getBodyLargeTextStyle().copyWith(
          fontWeight: FontWeight.bold,
          color: context.subTitleColor,
        ),
      ),
      Text(
        value,
        style: getTitleMediumPrimaryColorTextStyle().copyWith(
          color: valueColor,
        ),
      ),
    ],
  );
}
