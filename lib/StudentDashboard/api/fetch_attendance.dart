import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/AttendanceScreen/model/attendance_model.dart';
import 'util/api_endpoints.dart';

// METHOD: fetch student attendance data by required parameters (studentId, password)
Future<List<Attendances>> fetchAttendanceData(
    String studentId, String password) async {
  // Define API
  // const String apiUrl = ApiEndpoints.attendanceData;
  final String apiUrl = ApiEndpoints.attendanceData;

  try {
    // Create the form-data request using POST
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['student_id'] = studentId; // Set the student ID
    request.fields['pwd'] = password; // Set the password

    // Send the request and await the response
    var response = await request.send();

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Convert the response stream to a regular HTTP response
      var responseData = await http.Response.fromStream(response);

      // Decode the JSON response
      var jsonResponse = jsonDecode(responseData.body);

      // Check if the attendance data exists in the response
      if (jsonResponse['attendance_data'] != null &&
          jsonResponse['attendance_data'].isNotEmpty) {
        // Parse the attendance data and return as a list
        return (jsonResponse['attendance_data'] as Map<String, dynamic>)
            .values
            .map((e) => Attendances.fromJson(e))
            .toList();
      } else {
        // Handle case where attendance data is missing or empty
        throw Exception('No attendance data found in response');
      }
    } else {
      // Log and throw error for failed HTTP response status codes
      print('Failed response status: ${response.statusCode}');
      throw Exception('Failed to load attendance data');
    }
  } catch (e) {
    // Catch and log any exceptions related to network or parsing
    print('Error fetching attendance data: $e');
    throw Exception('Error fetching attendance data');
  }
}
