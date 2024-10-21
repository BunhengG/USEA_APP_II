import 'package:url_launcher/url_launcher.dart'; // For launching URLs

Future<void> launchFeedback(String feedbackUrl) async {
  if (feedbackUrl.isNotEmpty) {
    if (await canLaunch(feedbackUrl)) {
      await launch(feedbackUrl);
    } else {
      throw 'Could not launch $feedbackUrl';
    }
  } else {
    print('Feedback URL is empty');
  }
}
