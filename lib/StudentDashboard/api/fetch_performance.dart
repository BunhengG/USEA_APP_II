import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Screens/PerformanceScreen/model/performance_model.dart';
import 'util/api_endpoints.dart';

// METHOD: fetch student performance data by required parameters (studentId, password)
Future<List<PerformanceClass>> fetchPerformanceData(
    String studentId, String password) async {
  // Define API
  // const String apiUrl = ApiEndpoints.performanceData;
  final String apiUrl = ApiEndpoints.performanceData;

  // Create the form-data request
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  request.fields['student_id'] = studentId; // Set the student ID
  request.fields['pwd'] = password; // Set the password

  // Send the request and await the response
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    // Convert the response stream to a regular HTTP response
    var responseData = await http.Response.fromStream(response);

    // Decode the JSON response
    var jsonResponse = jsonDecode(responseData.body);

    // Check if performance data exists
    if (jsonResponse['study_performance_data'] != null &&
        jsonResponse['study_performance_data'].isNotEmpty) {
      // Parse the performance data and return as a list
      return (jsonResponse['study_performance_data'] as Map<String, dynamic>)
          .values
          .map((e) => PerformanceClass.fromJson(e))
          .toList();
    } else {
      throw Exception('No performance data found in response');
    }
  } else {
    // If the response status is not 200, print and throw an error
    print('Failed response status: ${response.statusCode}');
    throw Exception('Failed to load performance data');
  }
}
