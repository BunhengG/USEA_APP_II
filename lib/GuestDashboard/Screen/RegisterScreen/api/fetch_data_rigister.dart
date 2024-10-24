import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../utils/api_domain.dart';

class ApiService {
  Future<List<dynamic>?> fetchData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Get the URL from ApiConfig
      final apiUrl = ApiConfig.getRegistrationDataUrl();

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decode the response body
        final data = jsonDecode(response.body);

        // Check if the data is a List
        if (data is List) {
          return data;
        } else {
          print('Unexpected data format');
          return null;
        }
      } else {
        print('Failed to load data');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
