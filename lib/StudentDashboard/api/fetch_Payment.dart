import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/PaymentPage/model/payment_model.dart';
import 'util/api_endpoints.dart';

class PaymentService {
  // Helper method to send requests
  Future<http.Response> _sendPostRequest(
      String apiUrl, String studentId, String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['student_id'] = studentId;
    request.fields['pwd'] = password;

    var response = await request.send();
    if (response.statusCode == 200) {
      return http.Response.fromStream(response);
    } else {
      throw Exception('Failed request with status: ${response.statusCode}');
    }
  }

  // METHOD: Fetch student payment data
  Future<List<PayStudy>> fetchPaymentData(
      String studentId, String password) async {
    // Define API
    // const String apiUrl = ApiEndpoints.paymentData;
    final String apiUrl = ApiEndpoints.paymentData;

    try {
      // Send POST request
      var responseData = await _sendPostRequest(apiUrl, studentId, password);

      // Parse JSON response
      var jsonResponse = jsonDecode(responseData.body);

      // Check if payment data exists and parse it
      if (jsonResponse['pay_study_data'] != null &&
          jsonResponse['pay_study_data'].isNotEmpty) {
        return (jsonResponse['pay_study_data'] as List)
            .map((e) => PayStudy.fromJson(e))
            .toList();
      } else {
        throw Exception('No payment data found in response');
      }
    } catch (error) {
      print('Error in fetchPaymentData: $error');
      rethrow;
    }
  }

  // METHOD: Fetch other payment data
  Future<List<OtherPayment>> fetchOtherPaymentData(
      String studentId, String password) async {
    // Define API
    // const String apiUrl = ApiEndpoints.paymentOtherData;
    final String apiUrl = ApiEndpoints.paymentOtherData;
    try {
      // Send POST request
      var responseData = await _sendPostRequest(apiUrl, studentId, password);

      // Parse JSON response
      var jsonResponse = jsonDecode(responseData.body);

      // Check if other payment data exists and parse it
      if (jsonResponse['pay_other_data'] != null &&
          jsonResponse['pay_other_data'].isNotEmpty) {
        return (jsonResponse['pay_other_data'] as List)
            .map((e) => OtherPayment.fromJson(e))
            .toList();
      } else {
        throw Exception('No other payment data found in response');
      }
    } catch (error) {
      print('Error in fetchOtherPaymentData: $error');
      rethrow;
    }
  }
}
