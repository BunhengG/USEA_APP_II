import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_domain.dart';
import '../model/fqaModel.dart';

class ApiService {
  Future<List<QuestionAnswer>> fetchFQA() async {
    final apiUrl = ApiConfig.getFQADataUrl(Get.locale?.languageCode ?? 'km');
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((item) => QuestionAnswer.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load FQA data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching FQA data: $e');
    }
  }
}
