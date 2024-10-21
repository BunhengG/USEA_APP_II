import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/FeedbackScreen/model/feedback_class.dart';
import 'util/api_endpoints.dart';

// METHOD: fetch feedback URL by required parameters (studentId, password)
Future<FeedbackClass?> fetchFeedbackData(
    String studentId, String password) async {
  // Define API URL for fetching feedback data
  // const String apiUrl = ApiEndpoints.feedbackData;
  final String apiUrl = ApiEndpoints.feedbackData;

  // Create the form-data request
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  request.fields['student_id'] = studentId; // Set the student ID
  request.fields['pwd'] = password; // Set the password

  try {
    // Send the request and await the response
    var response = await request.send();

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Convert the response stream to a regular HTTP response
      var responseData = await http.Response.fromStream(response);

      // Decode the JSON response
      var jsonResponse = jsonDecode(responseData.body);

      // Print the entire response for debugging
      print(
          'Response data: $jsonResponse'); // Add this line to see the full response

      // Check if feedback data exists
      if (jsonResponse['feedback_data'] != null &&
          jsonResponse['feedback_data'].isNotEmpty) {
        // Parse the feedback data and return the FeedbackClass object
        return FeedbackClass.fromJson(
          jsonResponse['feedback_data'][0],
        ); // Access the first item
      } else {
        throw Exception('No feedback data found in response');
      }
    } else {
      // Log and throw error for failed HTTP response status codes
      print('Failed response status: ${response.statusCode}');
      throw Exception('Failed to load feedback data');
    }
  } catch (e) {
    // Catch and log any exceptions related to network or parsing
    print('Error fetching feedback data: $e');
    throw Exception('Error fetching feedback data');
  }
}
