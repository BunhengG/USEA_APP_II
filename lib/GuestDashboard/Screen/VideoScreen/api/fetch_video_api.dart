import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../api/api_domain.dart';
import '../model/video_model.dart';

class ApiService {
  Future<List<VDO_Class>> fetchVideos() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      // Get the URL from ApiConfig
      final apiUrl = ApiConfig.getVideosDataUrl();

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => VDO_Class.fromJson(json)).toList();
      } else {
        print('Failed to load videos');
        return [];
      }
    } catch (e) {
      print('Error fetching videos: $e');
      return [];
    }
  }
}
