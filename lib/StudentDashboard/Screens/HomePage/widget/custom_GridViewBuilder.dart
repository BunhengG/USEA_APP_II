import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../localString/Data/dummy_data.dart';
import '../../FeedbackPage/func/FeedbackPage.dart';
import '../../FeedbackPage/model/feedback_class.dart';
import '../../../api/fetch_feedback.dart';
import '../../../helpers/shared_pref_helper.dart';
import 'custom_Student_GridItem.dart';
// import 'custom_GridItem.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  Future<void> navigateToPage(BuildContext context, String route) async {
    switch (route) {
      case '/schedule':
        Navigator.pushNamed(context, '/schedule');
        break;
      case '/performance':
        Navigator.pushNamed(context, '/performance');
        break;
      case '/attendance':
        Navigator.pushNamed(context, '/attendance');
        break;
      case '/payment':
        Navigator.pushNamed(context, '/payment');
        break;
      case '/job':
        Navigator.pushNamed(context, '/job');
        break;
      case '/study':
        Navigator.pushNamed(context, '/study');
        break;
      case '/achievement':
        Navigator.pushNamed(context, '/achievement');
        break;
      case '/feedback':
        // Fetch the student ID and password from SharedPreferences
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();

        if (studentId != null && password != null) {
          try {
            FeedbackClass? feedbackData =
                await fetchFeedbackData(studentId, password);
            if (feedbackData != null) {
              await launchFeedback(feedbackData.feedback);
            } else {
              print('No feedback data available');
            }
          } catch (e) {
            print('Error launching feedback: $e');
          }
        } else {
          print('Student ID or password is null');
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 1.6,
      ),
      itemCount: gridItemStudent.length,
      itemBuilder: (context, index) {
        String title = gridItemStudent[index]['title'];
        return CustomStudentGridItem(
          iconPath: gridItemStudent[index]['icon'],
          title: title.tr,
          onTap: () => navigateToPage(context, gridItemStudent[index]['route']),
        );
      },
    );
  }
}
