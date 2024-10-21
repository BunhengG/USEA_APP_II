import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/HomePage/model/credit_model.dart';
import 'util/api_endpoints.dart';

//METHOD: Function to fetch student credit by required parameters to pass from HomePage
Future<CreditData?> fetchCreditData(String studentId, String password) async {
  // Define API
  // const String apiUrl = ApiEndpoints.creditData;
  final String apiUrl = ApiEndpoints.creditData;

  //NOTE: Create the form-data request
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  //* we'll call with match fields from API Response
  request.fields['student_id'] = studentId; // Set the student ID
  request.fields['pwd'] = password; // Set the password

  // Send the request and await the response
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    var responseData = await http.Response.fromStream(response);
    // print('Response body: ${responseData.body}');

    var jsonResponse = jsonDecode(responseData.body);

    // Ensure there is valid credit data in the response
    if (jsonResponse['credit_data'] != null &&
        jsonResponse['credit_data'].isNotEmpty) {
      return CreditData.fromJson(jsonResponse['credit_data'][0]);
    } else {
      throw Exception('No credit data found in response');
    }
  } else {
    print('Failed response status: ${response.statusCode}');
    throw Exception('Failed to load credit data');
  }
}
