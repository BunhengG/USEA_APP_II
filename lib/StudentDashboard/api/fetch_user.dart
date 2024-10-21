import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests
import '../auth/model/login_model_class.dart';
import 'util/api_endpoints.dart';

Future<UserDataResponse?> loginStudent(
    String studentId, String password) async {
  // Define API
  // const String apiUrl = ApiEndpoints.loginUserData;
  final String apiUrl = ApiEndpoints.loginUserData;

  // Create the form-data request body
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  // Add form fields for the login (as per the API requirements)
  request.fields['student_id'] = studentId;
  request.fields['pwd'] = password;

  try {
    // Send the request
    var response = await request.send();

    // Convert the stream response into a readable format
    var responseString = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonData = jsonDecode(responseString.body);

      // Check if the response is valid and contains the required data
      if (jsonData != null && jsonData['student_users'] != null) {
        // Convert JSON to UserDataResponse model
        UserDataResponse userDataResponse = UserDataResponse.fromJson(jsonData);
        return userDataResponse; // Return the parsed model
      } else {
        print('Invalid response format');
        return null;
      }
    } else {
      print('Failed to log in. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error occurred: $e');
    return null;
  }
}
