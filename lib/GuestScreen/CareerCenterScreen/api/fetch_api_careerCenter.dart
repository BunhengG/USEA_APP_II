import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../config/api_domain.dart';
import '../model/careerCenterModel.dart';

class ApiService {
  Future<List<Career>> fetchCareers() async {
    final apiUrl =
        ApiConfig.getCareerCenterUrl(Get.locale?.languageCode ?? 'kh');
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((item) => Career.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load careers');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
