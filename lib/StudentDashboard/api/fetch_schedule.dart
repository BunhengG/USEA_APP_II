import '../Screens/ScheduleScreen/model/schedule_model_class.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'util/api_endpoints.dart';

class ScheduleRepository {
  // Method to fetch schedule data from the API.
  Future<List<ScheduleItem>> fetchScheduleData(
      String studentId, String password, String date) async {
    // Define API
    // const String apiUrl = ApiEndpoints.scheduleData;
    final String apiUrl = ApiEndpoints.scheduleData;

    // Create the form-data for the POST request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add necessary fields to the request.
    request.fields['student_id'] = studentId;
    request.fields['pwd'] = password;
    request.fields['date'] = date;

    // Set headers if needed
    // request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    // print('Sending request with: ${request.fields}');

    // Send the POST request and await the response
    var response = await request.send();
    // print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      var jsonResponse = jsonDecode(responseData.body);

      if (jsonResponse['schedule_data'] != null &&
          jsonResponse['schedule_data'].isNotEmpty) {
        // Map the 'schedule_data' list from the JSON response to a List<ScheduleItem>.
        return (jsonResponse['schedule_data'] as List)
            .map((data) => ScheduleItem.fromJson(data))
            .toList();
      } else {
        throw Exception('No schedule data found in response');
      }
    } else {
      throw Exception('Failed to fetch schedule data: ${response.statusCode}');
    }
  }
}
