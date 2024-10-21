// custom_calendar.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:useaapp_version_2/theme/constants.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';

import '../../../../theme/theme_provider/theme_utils.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CustomCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorMode = isDarkMode(context);
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.bgThirdDarkMode,
        borderRadius: const BorderRadius.all(Radius.circular(rd_MediumRounded)),
        shape: BoxShape.rectangle,
      ),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: selectedDate,
        selectedDayPredicate: (day) => isSameDay(day, selectedDate),
        onDaySelected: (selectedDay, focusedDay) {
          onDateSelected(selectedDay);
        },
        rowHeight: 50.h,
        calendarStyle: CalendarStyle(
          cellMargin: EdgeInsets.only(
            top: 10.r,
            bottom: 0.r,
            left: 5.r,
            right: 5.r,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(rd_SmallRounded),
            color: colorMode ? cl_ThirdColor : const Color(0xFFEEF0F2),
          ),
          todayTextStyle: const TextStyle(color: cl_PrimaryColor),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: context.activeSelectScheduleDarkMode,
            borderRadius: BorderRadius.circular(rd_SmallRounded),
          ),
          selectedTextStyle: TextStyle(
            color: cl_ThirdColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) {
            return DateFormat.E(locale).format(date).substring(0, 2);
          },
          weekendStyle: TextStyle(color: context.textDateColor),
          weekdayStyle: TextStyle(color: context.textDateColor),
        ),
        headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.only(bottom: 8.r),
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon:
              Icon(Icons.chevron_left, color: context.titlePrimaryColor),
          rightChevronIcon:
              Icon(Icons.chevron_right, color: context.titlePrimaryColor),
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
            color: context.titlePrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            bool isSunday = day.weekday == DateTime.sunday;
            return Container(
              height: 40.h,
              margin: EdgeInsets.symmetric(vertical: 0.r, horizontal: 5.r),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isSameDay(day, selectedDate)
                    ? context.activeSelectScheduleDarkMode
                    : isSunday
                        ? context.sundayScheduleDarkMode
                        : colorMode
                            ? cl_SecondaryColor_Mode
                            : const Color(0xFFEEF0F2),
                borderRadius: BorderRadius.circular(rd_SmallRounded),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isSameDay(day, selectedDate)
                        ? cl_ThirdColor
                        : isSunday
                            ? Colors.redAccent
                            : context.subTitleColor,
                    fontWeight: isSameDay(day, selectedDate)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
          // Handle tapped days not in the current month
          outsideBuilder: (context, day, focusedDay) {
            return Container(
              height: 40.h,
              margin: EdgeInsets.symmetric(vertical: 0.r, horizontal: 5.r),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.textNextMonthDateColor,
                borderRadius: BorderRadius.circular(rd_SmallRounded),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(color: context.textDecColor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
