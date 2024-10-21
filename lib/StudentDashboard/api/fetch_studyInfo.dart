import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/StudyInfo/model/studyInfo_model.dart';
import 'util/api_endpoints.dart';

// METHOD: fetch student StudyInfo data by required parameters (studentId, password)
Future<List<StudyInfo>> fetchStudyInfoData(
    String studentId, String password) async {
  // Define API
  // const String apiUrl = ApiEndpoints.studyInfoData;
  final String apiUrl = ApiEndpoints.studyInfoData;

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
    var jsonResponse = jsonDecode(responseData.body);

    // Check if StudyInfo data exists
    if (jsonResponse['study_info_data'] != null) {
      // Return the parsed data (could be an empty list)
      return (jsonResponse['study_info_data'] as List)
          .map((data) => StudyInfo.fromJson(data))
          .toList();
    } else {
      // Return an empty list instead of throwing an exception
      return [];
    }
  } else {
    // If the response status is not 200, print and throw an error
    print('Failed response status: ${response.statusCode}');
    var responseData = await http.Response.fromStream(response);
    print(
        'Failed response body: ${responseData.body}'); // Log the error response body
    throw Exception('Failed to load StudyInfo data');
  }
}
