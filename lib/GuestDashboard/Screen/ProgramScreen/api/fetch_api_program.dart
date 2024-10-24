import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../utils/api_domain.dart';
import '../models/acca_Models.dart';

class ApiService {
  // Function to fetch college data
  Future<List<dynamic>> fetchCollegeData() async {
    final apiUrl =
        ApiConfig.getStudyProgramUrl(Get.locale?.languageCode ?? 'kh');
    int retries = 3;
    const delayDuration = Duration(milliseconds: 500);

    while (retries > 0) {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['program_data'] is List) {
            return data['program_data'] as List<dynamic>;
          } else {
            print('Unexpected data format');
            return [];
          }
        } else {
          print('Failed to load data: ${response.statusCode}');
          return [];
        }
      } catch (e) {
        retries--;
        print('Error fetching data: $e. Retries left: $retries');
        if (retries == 0) {
          return [];
        } else {
          await Future.delayed(delayDuration);
        }
      }
    }
    return [];
  }

  // Function to fetch ProgramACCA data
  Future<ProgramACCA> fetchProgramACCA() async {
    final apiUrl = ApiConfig.getAccaUrl(Get.locale?.languageCode ?? 'en');
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProgramACCA.fromJson(
        data['program_acca'][0],
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}
