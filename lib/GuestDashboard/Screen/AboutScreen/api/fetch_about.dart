import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../utils/api_domain.dart';

class ApiService {
  static Future<List<dynamic>> fetchRecognitions() async {
    final apiUrl =
        ApiConfig.getAboutUsDataUrl(Get.locale?.languageCode ?? 'kh');
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data is List ? data : [];
      } else {
        throw Exception('Failed to load recognitions');
      }
    } catch (error) {
      print('Error fetching recognitions: $error');
      throw Exception('Failed to fetch recognitions: $error');
    }
  }
}
