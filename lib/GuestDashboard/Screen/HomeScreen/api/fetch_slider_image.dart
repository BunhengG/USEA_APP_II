import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchImages() async {
  await Future.delayed(const Duration(milliseconds: 500));

  final uri = Uri.parse('https://usea.edu.kh/api/webapi.php?action=slide_home');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) ?? [];
      return List<String>.from(
          data.map((item) => item['image_url'] as String? ?? ''));
    } else {
      throw Exception('Failed to load images');
    }
  } catch (e) {
    // print('Error fetching images: $e');
    return [];
  }
}
