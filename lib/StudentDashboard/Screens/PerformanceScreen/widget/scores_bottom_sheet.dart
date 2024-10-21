import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/color_builder.dart';

import '../../../../theme/constants.dart';
import '../../../../theme/text_style.dart';
import '../model/performance_model.dart';

// Method to build the BottomSheet for Scores data
void showScoresBottomSheet(
    BuildContext context, List<Scores> scores, String subjectName,
    {required Color backgroundColor}) {
  showModalBottomSheet(
    isScrollControlled: true,
    scrollControlDisabledMaxHeightRatio: 80,
    context: context,
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (context) {
      return ScoresBottomSheet(scores: scores, subjectName: subjectName);
    },
  );
}

class ScoresBottomSheet extends StatefulWidget {
  final List<Scores> scores;
  final String subjectName;

  const ScoresBottomSheet({
    super.key,
    required this.scores,
    required this.subjectName,
  });

  @override
  _ScoresBottomSheetState createState() => _ScoresBottomSheetState();
}

class _ScoresBottomSheetState extends State<ScoresBottomSheet>
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
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.8 * _heightAnimation.value,
          width: double.infinity,
          child: SingleChildScrollView(
            // Added ScrollView
            child: Column(
              children: [
                // Header
                Column(
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
                            widget.subjectName,
                            textAlign: TextAlign.center,
                            style:
                                getTitleSmallPrimaryColorTextStyle().copyWith(
                              color: context.titlePrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(context),
                  ],
                ),
                // Scrollable Body
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.scores.length,
                  itemBuilder: (context, index) {
                    final score = widget.scores[index];

                    // Split the score and final score values if they contain " / "
                    final attendanceScores =
                        _splitScoreString(score.scoreAttendance);
                    final attendanceFinalScores =
                        _splitScoreString(score.numberAttendance);

                    final assignmentScores =
                        _splitScoreString(score.scoreAssignment);
                    final assignmentFinalScores =
                        _splitScoreString(score.numberAssignment);

                    final midTermScores = _splitScoreString(score.scoreMidTerm);
                    final midTermFinalScores =
                        _splitScoreString(score.numberMidTerm);

                    final finalScores = _splitScoreString(score.scoreFinal);
                    final finalFinalScores =
                        _splitScoreString(score.numberFinal);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 26.0,
                            bottom: 8,
                            left: 16,
                            right: 16,
                          ),
                          child: Text(
                            score.title,
                            style:
                                getTitleSmallPrimaryColorTextStyle().copyWith(
                              color: context.titlePrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        //COMMENT: ******************************** Header Bottom Sheet ********************************
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'លក្ខណៈវិនិច្ឆ័យ'.tr,
                                  style: getBodyLargeTextStyle().copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.subTitleColor,
                                  ),
                                ),
                              ),
                              Text(
                                'ពិន្ទុជាក់ស្ដែង'.tr,
                                style: getBodyLargeTextStyle().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.subTitleColor,
                                ),
                              ),
                              const SizedBox(width: 38),
                              Text(
                                'ពិន្ទុសរុប'.tr,
                                style: getBodyLargeTextStyle().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.subTitleColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                        //COMMENT: ******************************** Body Bottom Sheet ********************************
                        buildScoreRow(
                          'វត្តមាន'.tr,
                          attendanceScores[0],
                          attendanceScores[1],
                          attendanceFinalScores[0],
                          attendanceFinalScores[1],
                          context,
                        ),
                        buildScoreRow(
                          'សមិទ្ធិផល'.tr,
                          assignmentScores[0],
                          assignmentScores[1],
                          assignmentFinalScores[0],
                          assignmentFinalScores[1],
                          context,
                        ),
                        buildScoreRow(
                          'ពាក់កណ្ដាលឆមាស'.tr,
                          midTermScores[0],
                          midTermScores[1],
                          midTermFinalScores[0],
                          midTermFinalScores[1],
                          context,
                        ),
                        buildScoreRow(
                          'ប្រលងបញ្ចប់ឆមាស'.tr,
                          finalScores[0],
                          finalScores[1],
                          finalFinalScores[0],
                          finalFinalScores[1],
                          context,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1.5,
      color: context.secondaryColoDarkMode,
    );
  }
}

//METHOD: Function to split the score string
List<String> _splitScoreString(String score) {
  if (score == "N/A") {
    return ['0', 'N/A'];
  }

  //? Split the string by " / "
  List<String> parts = score.split(' / ');

  if (parts.length == 1) {
    return [parts[0], 'N/A'];
  }

  if (parts.length < 2) {
    return [parts[0], 'N/A'];
  }

  return parts;
}

//METHOD: Updated Function to create a score row with two columns
Widget buildScoreRow(
    String criteria,
    String scoreValue,
    String scoreBottomValue,
    String finalScoreValue,
    String finalScoreBottomValue,
    BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //COMMENT: ******************************** Criteria ********************************

        Container(
          width: 150.w,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rd_MediumRounded),
            color: context.secondaryColoDarkMode,
          ),
          child: Text(
            criteria,
            style:
                getBodyLargeTextStyle().copyWith(color: context.subTitleColor),
          ),
        ),

        SizedBox(width: 16.w),
        //COMMENT: ******************************** Score ********************************
        Container(
          width: 70.w,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rd_MediumRounded),
            color: context.scoreDarkMode,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                scoreValue,
                style: getTitleMediumTextStyle()
                    .copyWith(color: context.titleColor),
              ),
              Container(
                width: 36,
                height: 1,
                color: cl_SecondaryColor,
              ),
              Text(
                scoreBottomValue,
                style: getTitleMediumTextStyle()
                    .copyWith(color: context.titleColor),
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        //COMMENT: ******************************** Final ********************************
        Container(
          width: 70.w,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rd_MediumRounded),
            color: context.finalScoreDarkMode,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                finalScoreValue,
                style: getTitleMediumTextStyle()
                    .copyWith(color: context.titleColor),
              ),
              Container(
                width: 36,
                height: 1,
                color: cl_SecondaryColor,
              ),
              Text(
                finalScoreBottomValue,
                style: getTitleMediumTextStyle()
                    .copyWith(color: context.titleColor),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
